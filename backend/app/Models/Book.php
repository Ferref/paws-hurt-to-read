<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Book extends Model
{
    protected $connection = 'mongodb';
    
    protected $fillable = [
        'id',
        'title',
        'alternative_title',
        'authors',
        'subjects',
        'bookshelves',
        'formats',
        'download_count',
        'issued',
        'summary',
        'reading_ease_score',
        'cover_image',
        'removed_from_catalog'
    ];

    public function users()
    {
        return $this->belongsToMany(User::class, 'user_books', 'book_id', 'user_id');
    }

    public function userBooks()
    {
        return $this->hasMany(UserBooks::class);
    }
}
