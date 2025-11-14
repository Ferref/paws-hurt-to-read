<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BookController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/book/{id}', [BookController::class, 'getBook']);
Route::get('/book-covers/{range}', [BookController::class, 'getBookCovers']);