<?php

namespace App\Filament\Widgets;

use App\Enums\TicketPriority;
use App\Enums\TicketStatus;
use App\Filament\Concerns\HasModuleWidgetGate;
use App\Models\Ticket;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Filament\Widgets\Widget;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;

class TicketStatsWidget extends Widget
{
    use HasModuleWidgetGate;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::HELPDESK_TICKETS;

    protected static string $view = 'filament.widgets.ticket-stats-widget';

    protected static ?string $pollingInterval = '60s';

    protected static bool $isLazy = true;

    protected static ?int $sort = 5;

    protected int|string|array $columnSpan = 'full';

    public static function canView(): bool
    {
        $user = Auth::user();

        // Always check for module enablement first
        if (! static::passesModuleWidgetGate()) {
            return false;
        }

        // Return false if there is no authenticated user or if the user has the 'Member' role.
        if (! $user || $user->hasRole($user::ROLE_MEMBER)) {
            return false;
        }

        // Dashboard admin & super_admin hanya menampilkan tiket terbaru — statistik disembunyikan.
        if ($user->isItAdmin()) {
            return false;
        }

        return true;
    }

    /**
     * Generate SQL placeholders for an array of values.
     */
    private function placeholders(array $values): string
    {
        return implode(',', array_fill(0, count($values), '?'));
    }

    public function getStats(): array
    {
        $user = auth()->user();
        $isAdmin = $user->isItAdmin();
        $cacheKey = 'ticket_stats_widget_'.($isAdmin ? 'admin' : 'user_'.$user->id);

        $stats = Cache::remember($cacheKey, now()->addMinute(), function () use ($user, $isAdmin) {
            $openValues = TicketStatus::openValues();
            $completedValues = TicketStatus::completedValues();
            $highPriorityValues = TicketPriority::highValues();
            $currentMonth = now()->month;
            $currentYear = now()->year;
            $today = today()->toDateString();

            // Single aggregated query instead of 8 separate COUNT queries
            $baseQuery = Ticket::query();
            if (! $isAdmin) {
                $baseQuery->where('user_id', $user->id);
            }

            $row = (clone $baseQuery)->selectRaw("
                SUM(status = ?) as new_tickets,
                SUM(status = ?) as in_progress_tickets,
                SUM(status = ?) as waiting_user_tickets,
                SUM(status IN ({$this->placeholders($openValues)}) AND assigned_to IS NULL) as unassigned_tickets,
                SUM(status IN ({$this->placeholders($openValues)}) AND priority IN ({$this->placeholders($highPriorityValues)})) as high_priority_open,
                SUM(status IN ({$this->placeholders($completedValues)}) AND MONTH(resolved_at) = ? AND YEAR(resolved_at) = ?) as resolved_this_month,
                SUM(DATE(created_at) = ?) as today_tickets,
                SUM(MONTH(created_at) = ? AND YEAR(created_at) = ?) as monthly_tickets
            ", [
                TicketStatus::Open->value,
                TicketStatus::InProgress->value,
                TicketStatus::WaitingForUser->value,
                ...$openValues,
                ...$openValues,
                ...$highPriorityValues,
                ...$completedValues,
                $currentMonth,
                $currentYear,
                $today,
                $currentMonth,
                $currentYear,
            ])->first();

            $avgFirstResponseMinutes = $isAdmin
                ? Ticket::whereMonth('created_at', $currentMonth)
                    ->whereYear('created_at', $currentYear)
                    ->whereNotNull('first_responded_at')
                    ->selectRaw('AVG(TIMESTAMPDIFF(MINUTE, created_at, first_responded_at)) as avg_minutes')
                    ->value('avg_minutes')
                : null;

            return [
                'newTickets' => (int) ($row->new_tickets ?? 0),
                'inProgressTickets' => (int) ($row->in_progress_tickets ?? 0),
                'waitingUserTickets' => (int) ($row->waiting_user_tickets ?? 0),
                'unassignedTickets' => (int) ($row->unassigned_tickets ?? 0),
                'highPriorityOpen' => (int) ($row->high_priority_open ?? 0),
                'resolvedThisMonth' => (int) ($row->resolved_this_month ?? 0),
                'todayTickets' => (int) ($row->today_tickets ?? 0),
                'monthlyTickets' => (int) ($row->monthly_tickets ?? 0),
                'avgFirstResponseMinutes' => $avgFirstResponseMinutes ? round($avgFirstResponseMinutes) : null,
            ];
        });

        return [
            Stat::make('Tiket Baru', $stats['newTickets'])
                ->description("{$stats['todayTickets']} tiket masuk hari ini")
                ->descriptionIcon('heroicon-m-inbox-arrow-down')
                ->color($stats['newTickets'] > 5 ? 'danger' : ($stats['newTickets'] > 0 ? 'warning' : 'success'))
                ->chart([3, 4, 2, 5, 3, $stats['newTickets']]),

            Stat::make('Dalam Proses', $stats['inProgressTickets'])
                ->description('Sedang ditangani')
                ->descriptionIcon('heroicon-m-arrow-path')
                ->color($stats['inProgressTickets'] > 0 ? 'info' : 'gray')
                ->chart([2, 3, 4, 3, 5, $stats['inProgressTickets']]),

            Stat::make('Menunggu User', $stats['waitingUserTickets'])
                ->description('Perlu respons user')
                ->descriptionIcon('heroicon-m-clock')
                ->color($stats['waitingUserTickets'] > 0 ? 'warning' : 'success')
                ->chart([1, 2, 1, 3, 2, $stats['waitingUserTickets']]),

            Stat::make('Belum Ditugaskan', $stats['unassignedTickets'])
                ->description('Perlu segera ditugaskan')
                ->descriptionIcon('heroicon-m-user-plus')
                ->color($stats['unassignedTickets'] > 0 ? 'danger' : 'success')
                ->chart([1, 0, 2, 1, 1, $stats['unassignedTickets']]),

            Stat::make('Prioritas Tinggi', $stats['highPriorityOpen'])
                ->description('High & Critical terbuka')
                ->descriptionIcon('heroicon-m-fire')
                ->color($stats['highPriorityOpen'] > 0 ? 'danger' : 'success')
                ->chart([2, 1, 3, 2, 1, $stats['highPriorityOpen']]),

            Stat::make('Selesai Bulan Ini', $stats['resolvedThisMonth'])
                ->description("{$stats['monthlyTickets']} total tiket ".now()->translatedFormat('F'))
                ->descriptionIcon('heroicon-m-check-badge')
                ->color('success')
                ->chart([4, 6, 5, 7, 8, $stats['resolvedThisMonth']]),

            ...(($isAdmin && $stats['avgFirstResponseMinutes'] !== null) ? [
                Stat::make(
                    'Avg. First Response',
                    $stats['avgFirstResponseMinutes'] < 60
                        ? $stats['avgFirstResponseMinutes'].' mnt'
                        : round($stats['avgFirstResponseMinutes'] / 60, 1).' jam'
                )
                    ->description('Rata-rata respons pertama bulan ini')
                    ->descriptionIcon('heroicon-m-bolt')
                    ->color($stats['avgFirstResponseMinutes'] <= 60 ? 'success' : ($stats['avgFirstResponseMinutes'] <= 240 ? 'warning' : 'danger')),
            ] : []),
        ];
    }
}
