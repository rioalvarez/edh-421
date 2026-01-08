<?php

namespace App\Http\Controllers;

use App\Models\Article;
use Illuminate\Http\Request;

class ArticleController extends Controller
{
    public function show($slug)
    {
        // Cari artikel berdasarkan slug dan pastikan statusnya published
        // Jika tidak ditemukan, akan otomatis 404
        $article = Article::where('slug', $slug)
            ->published()
            ->firstOrFail();

        // IMPLEMENTASI AUTO-INCREMENT
        // Panggil fungsi yang sudah ada di Model
        $article->incrementViews();
        
        // Refresh model agar angka views yang ditampilkan adalah yang terbaru
        $article->refresh();

        // Tampilkan view
        return view('article', compact('article'));
    }
}
