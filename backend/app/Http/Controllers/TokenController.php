<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\JsonResponse;

use App\Services\TokenService;

class TokenController extends Controller
{
    public function refresh(Request $request): JsonResponse
    {
        $refreshToken = $request->header('X-Refresh-Token');

        if (!$refreshToken) {
            return response()->json([
                'message' => 'Refresh token missing',
            ], 401);
        }

        $tokens = app(TokenService::class)->refresh($refreshToken);

        return response()->json($tokens, 200);
    }
}
