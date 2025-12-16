<?php

namespace App\Http\Controllers;

use Illuminate\Validation\ValidationException;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

use DateTimeImmutable;
use Lcobucci\JWT\Builder;
use Lcobucci\JWT\JwtFacade;
use Lcobucci\JWT\Signer\Hmac\Sha256;
use Lcobucci\JWT\Signer\Key\InMemory;


use App\Models\User;
use App\Models\Book;

class SessionController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:100',
                'password' => 'required|string|min:8|max:20',
            ]);

            if (!Auth::attempt($validated)) {
                throw ValidationException::withMessages([
                    // Not displaying which data for security reasons!
                    'message' => ['The provided credentials are incorrect.'],
                ]);
            }

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 401);
        }

        $user = Auth::user();

        $key = InMemory::base64Encoded(
            config('jwt.secret')
        );

        $token = (new JwtFacade())->issue(
            new Sha256(),
            $key,
            static fn (
                Builder $builder,
                DateTimeImmutable $issuedAt
            ): Builder => $builder
                ->issuedBy('https://api.my-awesome-app.io')
                ->permittedFor('https://client-app.io')
                ->expiresAt($issuedAt->modify('+60 minutes'))
        );
        
        return response()->json([
            'message' => 'User logged in successfully',
            'auth_token' => $token->toString(),
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
        ], 201);
    }
}
