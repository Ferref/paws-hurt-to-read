<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class RefreshToken extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'refresh_tokens';

    protected $fillable = [
        'user_id',
        'token',
        'expires_at',
        'revoked_at',
        'device'
    ];
}