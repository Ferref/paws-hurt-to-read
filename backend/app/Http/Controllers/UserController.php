<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

use App\Models\User;
use App\Models\Book;

class UserController extends Controller
{
    public function register(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:100',
                'email' => 'required|string|email|regex:/^[A-Za-z]+@[A-Za-z]+\.[A-Za-z]+$/|max:255|unique:users',
                'password' => 'required|string|min:8|max:20|confirmed',
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        }

        $user = User::Create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'password' => bcrypt($validated['password']),
        ]);

        $user->save();

        Auth::login($user);
        
        return response()->json([
            'message' => 'User registered successfully',
            'auth_token' => $user->createToken('auth_token')->plainTextToken,
        ], 201);
    }
}
