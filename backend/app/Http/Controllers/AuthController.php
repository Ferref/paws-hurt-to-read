<?php

namespace App\Http\Controllers;

use Illuminate\Validation\ValidationException;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

use DateTimeImmutable;
use Lcobucci\JWT\Builder;
use Lcobucci\JWT\JwtFacade;
use Lcobucci\JWT\Signer\Hmac\Sha256;
use Lcobucci\JWT\Signer\Key\InMemory;


use App\Models\User;
use App\Models\Token;

class AuthController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:100',
                'password' => 'required|string|min:8|max:20',
            ]);

            $user = User::where('name', $validated['name'])->first();

            if (!$user || !Hash::check($validated['password'], $user->password)) {
                throw ValidationException::withMessages([
                    'message' => ['The provided credentials are incorrect.'],
                ]);
            }
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 401);
        }

        $key = InMemory::base64Encoded(
            config('jwt.secret')
        );

        $accessToken = (new JwtFacade())->issue(
            new Sha256(),
            $key,
            static fn(
                Builder $builder,
                DateTimeImmutable $issuedAt
            ): Builder => $builder
                ->issuedBy('https://api.my-awesome-app.io')
                ->permittedFor('https://client-app.io')
                ->expiresAt($issuedAt->modify('+60 minutes'))
        );

        $plainRefreshToken = Str::random(64);

        Token::create([
            'user_id' => $user->id,
            'token' => Hash::make($plainRefreshToken),
            'expires_at' => now()->addDays(30),
        ]);

        return response()->json([
            'message' => 'User logged in successfully',
            'access_token' => $accessToken->toString(),
            'refresh_token' => $plainRefreshToken,
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
        ], 201);
    }

    public function destroy(Request $request)
    {
        // Todo: destroy tokens
    }
}
