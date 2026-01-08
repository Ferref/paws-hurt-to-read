<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;
use MongoDB\Laravel\Relations\BelongsTo;

class UserBook extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'user_books';

    protected $fillable = [
        'user_id',
        'book_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', '_id');
    }

    public function book()
    {
        return $this->belongsTo(Book::class, 'book_id', '_id');
    }
}
