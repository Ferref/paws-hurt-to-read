<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

use App\Models\User;
use App\Models\Book;
use App\Models\UserBook;

class UserBookController extends Controller
{
    public function index(User $user): JsonResponse
    {
        if (Auth::user()->_id !== $user->_id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $books = User::with('userBooks.book')->find($user->id);

        if ($user->userBooks->isEmpty()) {
            return response()->json(['message' => 'Books not found for user'], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $books,
        ], 200);
    }

    public function store(User $user, Book $book): JsonResponse
    {
        if (Auth::user()->_id !== $user->_id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $exists = UserBook::where('user_id', $user->id)
            ->where('book_id', $book->id)
            ->exists();


        if ($exists) {
            return response()->json(['message' => 'Book already added for this user'], 409);
        }

        $userBook = UserBook::firstOrCreate([
            'user_id' => $user->_id,
            'book_id' => $book->_id,
            'cfi' => null
        ]);

        return response()->json([
            'success' => true,
            'data' => $userBook,
        ], 201);
    }

    public function destroy(User $user, Book $book): JsonResponse
    {
        if (Auth::user()->_id !== $user->_id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $userBook = UserBook::where('user_id', $user->_id)
            ->where('book_id', $book->_id)
            ->first();

        if (!$userBook) {
            return response()->json(['message' => 'Book not found for user'], 404);
        }

        $userBook->delete();

        return response()->json([
            'success' => true,
            'message' => 'Book deleted',
        ], 200);
    }
}
