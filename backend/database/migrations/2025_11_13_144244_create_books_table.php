<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('alternative_title')->nullable();
            $table->json('authors');
            $table->json('subjects');
            $table->json('bookshelves');
            $table->json('formats');
            $table->integer('download_count')->nullable();
            $table->dateTime('issued')->nullable();
            $table->text('summary')->nullable();
            $table->float('reading_ease_score')->nullable();
            $table->string('cover_image')->nullable();
            $table->boolean('removed_from_catalog')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('books');
    }
};
