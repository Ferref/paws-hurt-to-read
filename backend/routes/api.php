<?php

use Illuminate\Http\Request;

use App\Http\Controllers\BookController;
use App\Http\Controllers\RegistrationController;
use App\Http\Controllers\SessionController;

// Logged out routes
Route::post('/auth/register', [RegistrationController::class, 'store']);
Route::post('/auth/login', [SessionController::class, 'store']);

// Logged in routes
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/book/{id}', [BookController::class, 'show']);
    Route::get('/books/{range}', [BookController::class, 'index']);
    Route::post('/auth/logout', [SessionController::class, 'destroy']);
});