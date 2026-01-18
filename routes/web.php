<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ArticleController;

// Redirect root ke admin panel
Route::get('/', function () {
    return redirect('/admin');
});

// Route Publik Artikel
Route::get('/article/{slug}', [ArticleController::class, 'show'])->name('article.show');
