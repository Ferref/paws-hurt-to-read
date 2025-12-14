<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BookController;
use App\Http\Controllers\RegistrationController;
use App\Http\Controllers\SessionController;

Route::get('/', function () {
    return view('welcom');
});

// Book
Route::get('/book/{id}', [BookController::class, 'show']);
Route::get('/books/{range}', [BookController::class, 'index']);

// User Registration
Route::post('/user', [RegistrationController::class, 'store']);

// User Session
Route::post('/session', [SessionController::class, 'store']);
Route::post('/session', [SessionController::class, 'destroy']);