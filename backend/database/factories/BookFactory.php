<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Book>
 */
class BookFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
    }
}


// $table->id();
// $table->string('title');
// $table->string('alternative_title')->nullable();
// $table->json('authors');
// $table->json('subjects');
// $table->json('bookshelves');
// $table->json('formats');
// $table->integer('download_count')->nullable();
// $table->dateTime('issued')->nullable();
// $table->text('summary')->nullable();
// $table->float('reading_ease_score')->nullable();
// $table->string('cover_image')->nullable();
// $table->boolean('removed_from_catalog')->nullable();
// $table->timestamps();