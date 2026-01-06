<?php

declare(strict_types=1);

namespace App\Services;

use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

use DateTimeImmutable;
use Lcobucci\JWT\Builder;
use Lcobucci\JWT\JwtFacade;
use Lcobucci\JWT\Signer\Hmac\Sha256;
use Lcobucci\JWT\Signer\Key\InMemory;

use App\Models\RefreshToken;
use App\Models\User;

class TokenService
{
    public function issueForUser(User $user): array
    {
        return $this->issueTokens((string) $user->id);
    }

    public function refresh(string $plainRefreshToken): array
    {
        $refreshToken = RefreshToken::whereNull('revoked_at')
            ->where('expires_at', '>', now())
            ->get()
            ->first(fn($t) => Hash::check($plainRefreshToken, $t->token));

        if (!$refreshToken) {
            abort(401);
        }

        $refreshToken->update([
            'revoked_at' => now(),
        ]);

        return $this->issueTokens((string) $refreshToken->user_id);
    }

    private function issueTokens(string $userId): array
    {
        $plainRefreshToken = $this->createRefreshToken($userId);
        $accessToken = $this->createAccessToken($userId);

        return [
            'access_token' => $accessToken,
            'refresh_token' => $plainRefreshToken,
        ];
    }

    private function createRefreshToken(string $userId): string
    {
        $plainRefreshToken = Str::random(64);

        RefreshToken::create([
            'user_id' => $userId,
            'token' => Hash::make($plainRefreshToken),
            'expires_at' => now()->addMonth(),
        ]);

        return $plainRefreshToken;
    }

    private function createAccessToken(string $userId): string
    {
        return (new JwtFacade())->issue(
            new Sha256(),
            InMemory::plainText(config('jwt.secret')),
            static fn(Builder $builder, DateTimeImmutable $now) => $builder
                ->issuedBy(config('app.url'))
                ->relatedTo($userId)
                ->issuedAt($now)
                ->expiresAt($now->modify('+15 minutes'))
        )->toString();
    }
}