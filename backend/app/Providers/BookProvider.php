<?php

declare(strict_types=1);

namespace App\Providers;
use Illuminate\Support\Facades\Http;

class BookProvider
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
                return $data;
            }

            return [];
        } catch (\Throwable $e) {
            echo $e->getMessage();
        }
    }
}
