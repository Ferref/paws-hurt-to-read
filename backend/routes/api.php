<?php

use Illuminate\Http\Request;

use App\Http\Controllers\BookController;
use App\Http\Controllers\RegistrationController;
use App\Http\Controllers\SessionController;

// use App\Http\Middleware\CheckJwtToken;

// Logged out routes
Route::post('/auth/register', [RegistrationController::class, 'store']);
Route::post('/auth/login', [SessionController::class, 'store']);

// Logged in routes
Route::get('/books/{id}', [BookController::class, 'show']);
Route::get('/books/range/{range}', [BookController::class, 'index']);
Route::post('/auth/logout', [SessionController::class, 'destroy']);

// TODO: Logged in requests use tokens
// TODO: Logged in requests use refresh tokens
