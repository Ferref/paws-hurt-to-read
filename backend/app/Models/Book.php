<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Book extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'books';

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

    public function userBooks()
    {
        return $this->hasMany(UserBook::class, 'book_id', '_id');
    }

    public function users()
    {
        return $this->hasManyThrough(
            User::class,
            UserBook::class,
            'book_id',
            '_id',
            '_id',
            'user_id'
        );
    }
}
