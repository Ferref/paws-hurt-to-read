<?php

declare(strict_types=1);

namespace App\Providers;
use Illuminate\Support\Facades\Http;
use \App\Models\Book;

class BookRepository
{
    public function fetchBooks(array $ids): array
    {
        $host = config('services.book_provider.host');
        $key = config('services.book_provider.key');
        $books = config("services.book_provider.books") . '?' . http_build_query(['ids' => implode(',', $ids)]);

        try {
            $response = Http::withHeaders([
                'x-rapidapi-host' => $host,
                'x-rapidapi-key' => $key,
            ])->get($books);

            if ($response->successful()) {
                $data = $response->json();
                return $data['results'] ?? [];
            }

            return [];
        } catch (\Throwable $e) {
            echo $e->getMessage();
        }
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
}
