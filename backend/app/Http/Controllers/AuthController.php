<?php

namespace App\Http\Controllers;

use Illuminate\Validation\ValidationException;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;

use App\Services\TokenService;
use App\Models\User;
use App\Models\RefreshToken;

class AuthController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|min:3|max:20|exists:users,name',
                'password' => 'required|string|min:8|max:20',
            ]);

            $user = User::where('name', $validated['name'])->first();

            if (!$user || !Hash::check($validated['password'], $user->password)) {
                throw ValidationException::withMessages([
                    'message' => ['The provided credentials are incorrect.'],
                ]);
            }
        } catch (ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 401);
        }

        $tokens = app(TokenService::class)->issueForUser($user);

        return response()->json([
            'message' => 'User logged in successfully',
            'access_token' => $tokens['access_token'],
            'refresh_token' => $tokens['refresh_token'],
            'id' => (string)$user->_id,
            'name' => $user->name,
            'email' => $user->email,
        ], 201);
    }

    public function destroy(Request $request): JsonResponse
    {
        $plainRefreshToken = $request->string('refresh_token');

        $refreshToken = RefreshToken::whereNull('revoked_at')
            ->get()
            ->first(fn($t) => Hash::check($plainRefreshToken, $t->token));

        if ($refreshToken) {
            $refreshToken->update(['revoked_at' => now()]);
        }

        return response()->json(['message' => 'Logged out'], 200);
    }
}