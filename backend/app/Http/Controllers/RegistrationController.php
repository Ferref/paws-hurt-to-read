<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;

use App\Services\TokenService;

use App\Models\User;

class RegistrationController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|min:3|max:20|unique:users',
                'email' => 'required|string|email|regex:/^[A-Za-z0-9.]+@[A-Za-z0-9]+[.][A-Za-z0-9.]+$/|max:255|unique:users',
                'password' => 'required|string|min:8|max:20',
                'password_confirmation' => 'required|string|min:8|max:20|same:password',
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        }

        $user = new User();
        $user->name = $validated['name'];
        $user->email = $validated['email'];
        $user->password = bcrypt($validated['password']);
        $user->save();

        $tokens = app(TokenService::class)->issueForUser($user);

        return response()->json([
            'message' => 'User registered successfully',
            'access_token' => $tokens['access_token'],
            'refresh_token' => $tokens['refresh_token'],
            'id' => (string) $user->id,
            'name' => $user->name,
            'email' => $user->email,
        ], 201);
    }

    public function updateEmail(Request $request): JsonResponse
    {
        $user = $request->user();

        try {
            $validated = $request->validate([
                'old_email' => ['required', 'email'],
                'new_email' => ['required', 'email'],
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'errors' => $e->errors(),
            ], 422);
        }

        if ($validated['old_email'] === $validated['new_email']) {
            return response()->json([
                'message' => 'Old email is the same as new email',
            ], 400);
        }

        if ($user->email !== $validated['old_email']) {
            return response()->json([
                'message' => 'Old email does not match',
            ], 400);
        }

        if (
            User::where('email', $validated['new_email'])
            ->where('_id', '!=', $user->_id)
            ->exists()
        ) {
            return response()->json([
                'message' => 'Email already in use',
            ], 409);
        }

        $user->email = $validated['new_email'];
        $user->save();

        return response()->json([
            'message' => 'Email updated successfully',
            'email' => $user->email,
        ], 200);
    }

    public function updatePassword(Request $request, TokenService $tokenService): JsonResponse
    {
        $user = $request->user();

        $validated = $request->validate([
            'old_password' => 'required|string|min:8|max:20',
            'new_password' => 'required|string|min:8|max:20|confirmed',
        ]);

        if (!Hash::check($validated['old_password'], $user->password)) {
            return response()->json([
                'message' => 'Old password does not match',
            ], 400);
        }

        if (Hash::check($validated['new_password'], $user->password)) {
            return response()->json([
                'message' => 'New password must be different from the old password',
            ], 400);
        }

        $user->password = Hash::make($validated['new_password']);
        $user->save();

        $tokens = $tokenService->rotateTokensForUser($user);

        return response()->json([
            'message' => 'Password updated successfully',
            'access_token' => $tokens['access_token'],
            'refresh_token' => $tokens['refresh_token'],
        ], 200);
    }
}
