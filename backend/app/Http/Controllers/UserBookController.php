<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

use App\Models\User;
use App\Models\Book;
use App\Models\UserBooks;

final class UserBookController extends Controller
{
    public function store(User $user, Book $book): JsonResponse
    {
        if (Auth::user()->_id !== $user->_id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $exists = UserBooks::where('user_id', $user->id)
            ->where('book_id', $book->id)
            ->exists();


        if ($exists) {
            return response()->json(['message' => 'Book already added for this user'], 409);
        }
        
        $userBook = UserBooks::firstOrCreate([
            'user_id' => $user->_id,
            'book_id' => $book->_id,
        ]);

        return response()->json([
            'success' => true,
            'data' => $userBook,
        ], 201);
    }
}
