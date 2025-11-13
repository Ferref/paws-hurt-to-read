<?php

declare(strict_types=1);

namespace App\Providers;

// Services
use Illuminate\Support\ServiceProvider;
use Psr\Log\LoggerInterface as Logger;
use App\Repositories\BookRepository;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(BookRepository::class, function ($app) {
            return new BookRepository(
                $this->app->make(Logger::class));
        }); 
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
