<?php

declare(strict_types=1);

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

use App\Models\User;
use Illuminate\Support\Facades\Auth;

use Lcobucci\JWT\JwtFacade;
use Lcobucci\JWT\Validation\Constraint\SignedWith;
use Lcobucci\JWT\Validation\Constraint\LooseValidAt;
use Lcobucci\JWT\Signer\Hmac\Sha256;
use Lcobucci\JWT\Signer\Key\InMemory;
use Lcobucci\Clock\SystemClock;

class CheckJwtToken
{
    public function __construct(
        private JwtFacade $jwtFacade
    ) {}

    public function handle(Request $request, Closure $next): Response
    {
        $tokenString = $request->bearerToken();

        if ($tokenString === null) {
            return response()->json(['error' => 'Missing token'], 401);
        }

        try {
            $token = $this->jwtFacade->parse(
                $tokenString,
                new SignedWith(
                    new Sha256(),
                    InMemory::plainText((string) config('jwt.secret'))
                ),
                new LooseValidAt(SystemClock::fromUTC())
            );

            $userId = (string) $token->claims()->get('sub');

            $user = User::find($userId);

            if ($user === null) {
                return response()->json(['error' => 'User not found'], 401);
            }

            Auth::setUser($user);

            return $next($request);
        } catch (\Throwable) {
            return response()->json(['error' => 'Invalid token'], 401);
        }
    }
}
