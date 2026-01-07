<?php

namespace App\Filament\Widgets;

use App\Models\Ticket;
use Filament\Widgets\Widget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class TicketStatsWidget extends Widget
{
    protected static string $view = 'filament.widgets.ticket-stats-widget';

    protected static ?string $pollingInterval = '30s';

    protected static ?int $sort = 5;

    protected int | string | array $columnSpan = 'full';

    public static function canView(): bool
    {
        return auth()->user()->hasRole('super_admin');
    }

    public function getStats(): array
    {
        // Tiket terbuka (open, in_progress, waiting_for_user)
        $openTickets = Ticket::whereIn('status', ['open', 'in_progress', 'waiting_for_user'])->count();

        // Tiket yang baru masuk (status open)
        $newTickets = Ticket::where('status', 'open')->count();

        // Tiket dalam proses
        $inProgressTickets = Ticket::where('status', 'in_progress')->count();

        // Tiket menunggu user
        $waitingUserTickets = Ticket::where('status', 'waiting_for_user')->count();

        // Tiket belum ditugaskan
        $unassignedTickets = Ticket::whereIn('status', ['open', 'in_progress'])
            ->whereNull('assigned_to')
            ->count();

        // Tiket prioritas tinggi/kritis yang masih terbuka
        $highPriorityOpen = Ticket::whereIn('status', ['open', 'in_progress', 'waiting_for_user'])
            ->whereIn('priority', ['high', 'critical'])
            ->count();

        // Tiket selesai bulan ini
        $resolvedThisMonth = Ticket::whereIn('status', ['resolved', 'closed'])
            ->whereMonth('resolved_at', now()->month)
            ->whereYear('resolved_at', now()->year)
            ->count();

        // Tiket baru hari ini
        $todayTickets = Ticket::whereDate('created_at', today())->count();

        // Total tiket bulan ini
        $monthlyTickets = Ticket::whereMonth('created_at', now()->month)
            ->whereYear('created_at', now()->year)
            ->count();

        return [
            Stat::make('Tiket Baru', $newTickets)
                ->description("{$todayTickets} tiket masuk hari ini")
                ->descriptionIcon('heroicon-m-inbox-arrow-down')
                ->color($newTickets > 5 ? 'danger' : ($newTickets > 0 ? 'warning' : 'success'))
                ->chart([3, 4, 2, 5, 3, $newTickets]),

            Stat::make('Dalam Proses', $inProgressTickets)
                ->description('Sedang ditangani')
                ->descriptionIcon('heroicon-m-arrow-path')
                ->color($inProgressTickets > 0 ? 'info' : 'gray')
                ->chart([2, 3, 4, 3, 5, $inProgressTickets]),

            Stat::make('Menunggu User', $waitingUserTickets)
                ->description('Perlu respons user')
                ->descriptionIcon('heroicon-m-clock')
                ->color($waitingUserTickets > 0 ? 'warning' : 'success')
                ->chart([1, 2, 1, 3, 2, $waitingUserTickets]),

            Stat::make('Belum Ditugaskan', $unassignedTickets)
                ->description('Perlu segera ditugaskan')
                ->descriptionIcon('heroicon-m-user-plus')
                ->color($unassignedTickets > 0 ? 'danger' : 'success')
                ->chart([1, 0, 2, 1, 1, $unassignedTickets]),

            Stat::make('Prioritas Tinggi', $highPriorityOpen)
                ->description('High & Critical terbuka')
                ->descriptionIcon('heroicon-m-fire')
                ->color($highPriorityOpen > 0 ? 'danger' : 'success')
                ->chart([2, 1, 3, 2, 1, $highPriorityOpen]),

            Stat::make('Selesai Bulan Ini', $resolvedThisMonth)
                ->description("{$monthlyTickets} total tiket " . now()->translatedFormat('F'))
                ->descriptionIcon('heroicon-m-check-badge')
                ->color('success')
                ->chart([4, 6, 5, 7, 8, $resolvedThisMonth]),
        ];
    }
}
