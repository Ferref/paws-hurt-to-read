<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BookController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/book-detail/{id}', [BookController::class, 'getBookDetailsById']);
Route::get('/book-covers/{range}', [BookController::class, 'getBookCoversByIdRange']);