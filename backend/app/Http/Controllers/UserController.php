<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\User;
use App\Models\Book;

class UserController extends Controller
{
    public function addToMyBooks(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'id' => 'required|integer|exists:books,id'
        ]);

        $bookId = $validated['id'];

        $user = auth()->user();

        if (!$user) {
            return response()->json(['message' => 'Unauthenticated'], 401);
        }

        $user->books()->syncWithoutDetaching([$bookId]);

        return response()->json(['message' => 'Book added succesfully'], 200);
    }

    public function getMyBooks(): JsonResponse
    {
        $user = auth()->user();

        if (!$user) {
            return response()->json(['message' => 'Unauthenticated'], 401);
        }

        $books = $user->books();

        return response()->json(json_encode($books), 200);
    }
}
