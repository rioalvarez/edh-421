<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ArticleController;

// Route::get('/', function () {
//     return view('welcome');
// });

// Route Publik Artikel
Route::get('/article/{slug}', [ArticleController::class, 'show'])->name('article.show');