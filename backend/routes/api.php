<?php

use Illuminate\Http\Request;

use App\Http\Controllers\BookController;
use App\Http\Controllers\RegistrationController;
use App\Http\Controllers\SessionController;

use App\Http\Middleware\CheckJwtToken;

// Logged out routes
Route::post('/auth/register', [RegistrationController::class, 'store']);
Route::post('/auth/login', [SessionController::class, 'store']);

// Logged in routes
// Route::middleware(CheckJwtToken::class)->group(function () {
// Todo: Implement, do not forget refresh tokens
Route::get('/book/{id}', [BookController::class, 'show']);
Route::get('/books/{range}', [BookController::class, 'index']);
Route::post('/auth/logout', [SessionController::class, 'destroy']);
// });