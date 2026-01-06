<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\JsonResponse;

use App\Services\TokenService;

class TokenController extends Controller
{
    public function refresh(Request $request): JsonResponse
    {
        $tokens = app(TokenService::class)->refresh($request->string('refresh_token'));

        return response()->json($tokens, 200);
    }
}
