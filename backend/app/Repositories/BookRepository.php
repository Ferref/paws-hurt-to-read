<?php

declare(strict_types=1);

namespace App\Repositories;

use Illuminate\Support\Facades\Http;
use Psr\Log\LoggerInterface as Logger;
use Illuminate\Support\Facades\Storage;

use \App\Models\Book;

class BookRepository
{
    private $logger;

    public function __construct(Logger $logger)
    {
        $this->logger = $logger;
    }

    public function fetchBooks(int $start, int $end): array
    {
        $host = config('services.book_provider.host');
        $key = config('services.book_provider.key');
        $booksEndpoint = config('services.book_provider.books_endpoint');

        $ids = range($start, $end);

        $booksEndpoint = 'https://' . $host . $booksEndpoint . '?' . http_build_query(['ids' => implode(',', $ids)]);

        try {
            $response = Http::withHeaders([
                'x-rapidapi-host' => $host,
                'x-rapidapi-key' => $key,
            ])->get($booksEndpoint);

            if ($response->successful()) {

                $data = $response->json();

                $this->logger->info('Fetched books successfully', [
                    'count' => count($data['results'] ?? [])
                ]);

                return $data['results'] ?? [];
            }
        } catch (\Throwable $e) {
            $this->logger->error('Failed to fetch books', ['error' => $e->getMessage()]);
        }

        return [];
    }

    public function saveBook(array $bookData): void
    {
        $book = Book::updateOrCreate(
            [
                'id' => $bookData['id'],
                'title' => $bookData['title'],
                'alternative_title' => $bookData['alternative_title'] ?? null,
                'authors' => $bookData['authors'],
                'subjects' => $bookData['subjects'],
                'bookshelves' => $bookData['bookshelves'],
                'formats' => $bookData['formats'],
                'download_count' => $bookData['download_count'] ?? null,
                'issued' => $bookData['issued'] ?? null,
                'summary' => $bookData['summary'] ?? null,
                'reading_ease_score' => $bookData['reading_ease_score'] ?? null,
                'cover_image' => $bookData['cover_image'] ?? null,
                'removed_from_catalog' => $bookData['removed_from_catalog'] ?? null,
            ]
        );

        $book->save();
    }

    public function getBookCoversByIdRange(int $min, int $max): array
    {
        return Book::whereBetween('id', [$min, $max])
            ->get(['title', 'cover_image'])
            ->toArray();
    }

    public function getBookDetailsById(int $id): ?Book
    {
        return Book::where('id', $id)->first();
    }

    public function downloadEpubs(): void
    {
        $books = Book::get();

        foreach ($books as $book) {
            $epubUrl = $book->formats['application/epub+zip'] ?? null;

            if (!$epubUrl) {
                $this->logger->info('No EPUB for book', [
                    'id' => $book->id,
                    'title' => $book->title,
                ]);
                continue;
            }

            $content = Http::get($epubUrl)->body();

            $filename = $book->id . '.epub';

            Storage::put("epubs/{$filename}", $content);

            $this->logger->info('Downloaded EPUB', [
                'id' => $book->id,
                'file' => $filename,
            ]);
        }
    }
}
