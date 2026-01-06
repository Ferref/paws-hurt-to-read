<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Validation\ValidationException;

use App\Models\User;
use App\Models\Book;
use App\Models\UserBooks;

class UserBookController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'token' => 'required|string|exists:users,token',
                'book_id' => 'required|integer|exists:books,_id',
            ]);
        } catch (ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 401);
        }

        $user = User::where('token', $validated['token'])->first();

        $book = Book::where('_id', $validated['book_id'])->first();

        if (!$book) {
            return response()->json(['message' => 'Book not found'], 404);
        }

        $userBook = UserBooks::firstOrCreate(
            [
                'user_id' => $user->_id,
                'book_id' => $book->_id,
            ],
            [
                'created_at' => now(),
                'updated_at' => now(),
            ]
        );

        return response()->json([
            'success' => true,
            'data' => $userBook,
        ], 201);
    }
}