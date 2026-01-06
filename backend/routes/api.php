<?php

use Illuminate\Http\Request;

use App\Http\Controllers\RegistrationController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserBookController;

use App\Http\Controllers\BookController;

// User
Route::post('/auth/register', [RegistrationController::class, 'store']);
Route::post('/auth/login', [AuthController::class, 'store']);
Route::post('/auth/logout', [AuthController::class, 'destroy']);

Route::post('/users/{userId}/books/{bookId}', [UserBookController::class, 'store']);

// TODO: Logged in requests use tokens
// TODO: Logged in requests use refresh tokens

// Books
Route::get('/books/{id}', [BookController::class, 'show']);
Route::get('/books/range/{range}', [BookController::class, 'index']);


