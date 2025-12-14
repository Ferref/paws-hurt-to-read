<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

use App\Models\User;
use App\Models\Book;

class SessionController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'email' => 'required|string|email',
                'password' => 'required|string',
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        }

        if (!Auth::attempt($validated)) {
            return response()->json(['message' => 'Invalid login credentials'], 401);
        }

        $user = Auth::user();

        return response()->json([
            'message' => 'User logged in successfully',
            'auth_token' => $user->createToken('auth_token')->plainTextToken,
        ], 200);
    }

    public function destroy(Request $request): JsonResponse
    {
        $user = $request->user();

        if ($user) {
            $currentToken = $request->user()->currentAccessToken();
            
            if ($currentToken) {
                $currentToken->delete();
            }

            Auth::logout();

            return response()->json(['message' => 'User logged out successfully'], 200);
        }

        return response()->json(['message' => 'No authenticated user found'], 401);
    }
}
