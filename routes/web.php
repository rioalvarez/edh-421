<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ArticleController;
use App\Http\Controllers\AttachmentController;
use App\Http\Controllers\TicketReportController;

// Redirect root ke admin panel
Route::get('/', function () {
    return redirect('/admin');
});

// Route Publik Artikel
Route::get('/article/{slug}', [ArticleController::class, 'show'])->name('article.show');

// Route Attachment (serve dari database)
Route::middleware('auth')->group(function () {
    Route::get('/attachment/{attachment}', [AttachmentController::class, 'show'])->name('attachment.show');
    Route::get('/attachment/{attachment}/download', [AttachmentController::class, 'download'])->name('attachment.download');
});

// Route Report Export (admin only)
Route::middleware(['auth'])->prefix('reports')->group(function () {
    Route::get('/tickets/export-excel', [TicketReportController::class, 'exportExcel'])->name('reports.tickets.excel');
    Route::get('/tickets/export-pdf', [TicketReportController::class, 'exportPdf'])->name('reports.tickets.pdf');
});
