<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Repositories\BookRepository;


class BookController extends Controller
{
    public function __construct() {
        $this->bookRepository = app(BookRepository::class);
    }
    
    public function show(int $id): JsonResponse
    {
        $book = $this->bookRepository->getBookDetailsById($id);
        return response()->json($book);
    }

    public function index(string $range): JsonResponse
    {
        $ids = explode('-', $range);
        $min = (int) $ids[0];
        $max = (int) $ids[1];

        $books = $this->bookRepository->getBookCoversByIdRange($min, $max);
        return response()->json($books);
    }
}
