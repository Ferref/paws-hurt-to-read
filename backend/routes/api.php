<?php

declare(strict_types=1);

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\RegistrationController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\TokenController;
use App\Http\Controllers\UserBookController;
use App\Http\Controllers\BookController;
use App\Http\Controllers\EpubController;

// Auth
Route::post('/auth/register', [RegistrationController::class, 'store']);
Route::middleware('jwt')->patch('/auth/users/email/{id}', [RegistrationController::class, 'updateEmail']);

Route::post('/auth/login', [AuthController::class, 'store']);

Route::middleware('jwt')->post('/auth/logout', [AuthController::class, 'destroy']);
Route::middleware('jwt')->post('/auth/refresh', [TokenController::class, 'refresh']);

// User books
Route::middleware('jwt')->get('/users/{user}/books', [UserBookController::class, 'index']);
Route::middleware('jwt')->post('/users/{user}/books/{book}', [UserBookController::class, 'store']);
Route::middleware('jwt')->delete('/users/{user}/books/{book}', [UserBookController::class, 'destroy']);

// Books
Route::middleware('jwt')->get('/books/{id}', [BookController::class, 'show']);
Route::middleware('jwt')->get('/books/range/{range}', [BookController::class, 'index']);

Route::middleware('jwt')->get('/epubs/{id}', [EpubController::class, 'show']);