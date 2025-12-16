<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

use DateTimeImmutable;
use Lcobucci\JWT\Builder;
use Lcobucci\JWT\JwtFacade;
use Lcobucci\JWT\Signer\Hmac\Sha256;
use Lcobucci\JWT\Signer\Key\InMemory;

class CheckJwtToken
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $tokenString = $request->bearerToken();

        if (!$tokenString) {
            return response()->json([
                'error' => 'Missing token.'
            ], 401);
        }

        try {
            $token = Jwtfacade::parse($tokenString);
            $key = config('jwt.secret');

            $token->validate(new SignedWith(new Sha256(), $key));
            $token->validate(new ValidAt(new DateTimeImmutable()));

            return $next($request);
        } catch (\Throwable $e) {
            return response()->json(['error' => 'Invalid token', 401]);
        }
        
    }
}
