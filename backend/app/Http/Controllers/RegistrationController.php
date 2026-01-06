<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;

use DateTimeImmutable;
use Lcobucci\JWT\Builder;
use Lcobucci\JWT\JwtFacade;
use Lcobucci\JWT\Signer\Hmac\Sha256;
use Lcobucci\JWT\Signer\Key\InMemory;

use App\Models\User;
use App\Models\Token;

class RegistrationController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:100|unique:users',
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

        $plainRefreshToken = Str::random(64);

        Token::create([
            'user_id' => $user->id,
            'token' => Hash::make($plainRefreshToken),
            'expires_at' => now()->addDays(30),
        ]);

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

        return response()->json([
            'message' => 'User registered successfully',
            'access_token' => $accessToken->toString(),
            'refresh_token' => $plainRefreshToken,
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
        ], 201);
    }
}
