<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BookController;
use App\Http\Controllers\UserController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/book/details/{id}', [BookController::class, 'getBookDetailsById']);
Route::get('/book/covers/{range}', [BookController::class, 'getBookCoversByIdRange']);
