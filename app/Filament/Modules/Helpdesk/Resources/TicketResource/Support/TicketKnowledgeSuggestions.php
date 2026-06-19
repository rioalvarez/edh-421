<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Support;

use App\Enums\TicketCategory;
use App\Filament\Modules\KnowledgeManagement\Resources\ArticleResource;
use App\Models\Article;
use Illuminate\Support\HtmlString;

class TicketKnowledgeSuggestions
{
    public static function render(?string $subject, ?string $ticketCategory): HtmlString
    {
        $subject = trim((string) $subject);

        if (strlen($subject) < 3) {
            return new HtmlString('<p class="text-sm text-gray-400 italic">Ketik minimal 3 karakter pada subjek untuk melihat artikel terkait...</p>');
        }

        $subjectKeywords = self::subjectKeywords($subject);
        $allKeywords = $subjectKeywords
            ->merge(self::categoryKeywords((string) $ticketCategory))
            ->unique()
            ->filter();

        if ($allKeywords->isEmpty()) {
            return new HtmlString('<p class="text-sm text-gray-400 italic">Tidak ada kata kunci yang dapat dianalisis.</p>');
        }

        $pool = Article::published()
            ->where(function ($query) use ($allKeywords) {
                foreach ($allKeywords as $keyword) {
                    $query->orWhere('title', 'like', "%{$keyword}%")
                        ->orWhere('content', 'like', "%{$keyword}%");
                }
            })
            ->limit(20)
            ->get(['id', 'title', 'slug', 'content']);

        if ($pool->isEmpty()) {
            return new HtmlString('<p class="text-sm text-gray-400 italic">Tidak ada artikel yang cocok.</p>');
        }

        $scored = $pool
            ->map(fn (Article $article) => [
                'article' => $article,
                'score' => self::score($article, $allKeywords, $subjectKeywords),
            ])
            ->sortByDesc('score')
            ->take(4);

        return new HtmlString(self::renderLinks($scored));
    }

    private static function subjectKeywords(string $subject)
    {
        $stopWords = [
            'dan', 'atau', 'yang', 'di', 'ke', 'dari', 'untuk', 'dengan', 'pada',
            'tidak', 'ada', 'ini', 'itu', 'sudah', 'bisa', 'saya', 'kami', 'aku',
            'the', 'and', 'or', 'is', 'in', 'to', 'for', 'of', 'a', 'an', 'not',
        ];

        return collect(preg_split('/[\s\-_,\.;:]+/', strtolower($subject)))
            ->filter(fn ($word) => strlen($word) >= 3 && ! in_array($word, $stopWords, true))
            ->unique()
            ->values();
    }

    private static function categoryKeywords(string $ticketCategory)
    {
        return collect(match ($ticketCategory) {
            TicketCategory::IncidentManagement->value => ['insiden', 'error', 'rusak', 'gagal', 'gangguan', 'tidak berfungsi'],
            TicketCategory::NetworkSupport->value => ['jaringan', 'wifi', 'internet', 'koneksi', 'network', 'lan', 'ip'],
            TicketCategory::AssetManagement->value => ['aset', 'perangkat', 'hardware', 'device', 'inventaris', 'laptop', 'komputer'],
            TicketCategory::UserSupport->value => ['akun', 'login', 'password', 'pengguna', 'reset', 'user'],
            TicketCategory::AccessManagement->value => ['akses', 'permission', 'login', 'password', 'hak akses', 'izin'],
            TicketCategory::SecuritySupport->value => ['keamanan', 'virus', 'malware', 'security', 'enkripsi', 'backup'],
            TicketCategory::ServiceRequest->value => ['instalasi', 'install', 'permintaan', 'request', 'setup', 'konfigurasi'],
            TicketCategory::ChangeManagement->value => ['update', 'upgrade', 'migrasi', 'perubahan', 'konfigurasi', 'setting'],
            TicketCategory::DocumentationKb->value => ['panduan', 'manual', 'tutorial', 'dokumentasi', 'cara', 'langkah'],
            default => [],
        });
    }

    private static function score(Article $article, $allKeywords, $subjectKeywords): int
    {
        $score = 0;
        $titleLower = strtolower($article->title);
        $contentLower = strtolower(strip_tags($article->content ?? ''));

        foreach ($allKeywords as $keyword) {
            if (str_contains($titleLower, $keyword)) {
                $score += 3;
            }
            if (str_contains($contentLower, $keyword)) {
                $score += 1;
            }
        }

        foreach ($subjectKeywords as $keyword) {
            if (str_contains($titleLower, $keyword)) {
                $score += 2;
            }
        }

        return $score;
    }

    private static function renderLinks($scored): string
    {
        $html = '<div class="grid grid-cols-1 sm:grid-cols-2 gap-2">';

        foreach ($scored as $item) {
            $article = $item['article'];
            $score = $item['score'];
            $url = ArticleResource::getUrl('view', ['record' => $article]);
            $title = e($article->title);
            $badgeColor = $score >= 8 ? '#16a34a' : ($score >= 4 ? '#d97706' : '#6b7280');

            $html .= <<<HTML
                <a href="{$url}" target="_blank" class="flex items-center gap-2 p-2 rounded-lg border border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors text-sm">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 flex-shrink-0 text-primary-500" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/></svg>
                    <span class="truncate flex-1 text-primary-600 dark:text-primary-400 hover:underline">{$title}</span>
                    <span class="text-xs font-medium px-1.5 py-0.5 rounded-full text-white flex-shrink-0" style="background-color:{$badgeColor}">{$score}</span>
                </a>
            HTML;
        }

        return $html.'</div>';
    }
}
