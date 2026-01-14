<?php

namespace App\Http\Controllers;

use App\Repositories\BookRepository;
use Symfony\Component\HttpFoundation\File\Exception\FileNotFoundException;

class EpubController extends Controller
{
    private BookRepository $bookRepository;

    public function __construct(BookRepository $bookRepository)
    {
        $this->bookRepository = $bookRepository;
    }

    public function show(int $id)
    {
        $file = $this->bookRepository->getEpubFile($id);

        return response()->streamDownload(
            function () use ($file) {
                readfile($file->getPathname());
            },
            "book_{$id}.epub",
            [
                'Content-Type' => 'application/epub+zip',
            ]
        );
    }
}
