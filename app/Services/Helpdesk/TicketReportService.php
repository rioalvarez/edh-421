<?php

namespace App\Services\Helpdesk;

use App\Enums\TicketCategory;
use App\Enums\TicketPriority;
use App\Enums\TicketStatus;
use App\Models\Ticket;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection as EloquentCollection;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\LazyCollection;

class TicketReportService
{
    /**
     * @return array{start: string, end: string}
     */
    public function periodDates(?string $period, ?string $startDate = null, ?string $endDate = null): array
    {
        $now = Carbon::now();

        return match ($period) {
            'weekly' => [
                'start' => $now->copy()->startOfWeek()->format('Y-m-d'),
                'end' => $now->copy()->endOfWeek()->format('Y-m-d'),
            ],
            'quarterly' => [
                'start' => $now->copy()->startOfQuarter()->format('Y-m-d'),
                'end' => $now->copy()->endOfQuarter()->format('Y-m-d'),
            ],
            'yearly' => [
                'start' => $now->copy()->startOfYear()->format('Y-m-d'),
                'end' => $now->copy()->endOfYear()->format('Y-m-d'),
            ],
            'custom' => [
                'start' => $startDate ?: $now->copy()->startOfMonth()->format('Y-m-d'),
                'end' => $endDate ?: $now->copy()->endOfMonth()->format('Y-m-d'),
            ],
            default => [
                'start' => $now->copy()->startOfMonth()->format('Y-m-d'),
                'end' => $now->copy()->endOfMonth()->format('Y-m-d'),
            ],
        };
    }

    public function periodLabel(string $startDate, string $endDate): string
    {
        $start = Carbon::parse($startDate)->translatedFormat('d M Y');
        $end = Carbon::parse($endDate)->translatedFormat('d M Y');

        return "{$start} - {$end}";
    }

    /**
     * @return array<string, int|float|null>
     */
    public function statistics(string $startDate, string $endDate): array
    {
        $query = Ticket::whereBetween('created_at', $this->dateRange($startDate, $endDate));

        $total = (clone $query)->count();
        $open = (clone $query)->where('status', TicketStatus::Open->value)->count();
        $inProgress = (clone $query)->where('status', TicketStatus::InProgress->value)->count();
        $waitingUser = (clone $query)->where('status', TicketStatus::WaitingForUser->value)->count();
        $resolved = (clone $query)->where('status', TicketStatus::Resolved->value)->count();
        $closed = (clone $query)->where('status', TicketStatus::Closed->value)->count();

        $avgResolutionTime = $this->averageDuration($startDate, $endDate, 'resolved_at', 'day');
        $avgFirstResponseTime = $this->averageDuration($startDate, $endDate, 'first_responded_at', 'minute');

        return [
            'total' => $total,
            'open' => $open,
            'in_progress' => $inProgress,
            'waiting_user' => $waitingUser,
            'resolved' => $resolved,
            'closed' => $closed,
            'avg_resolution_time' => $avgResolutionTime ? round((float) $avgResolutionTime) : 0,
            'avg_first_response_time' => $avgFirstResponseTime ? round((float) $avgFirstResponseTime) : null,
            'resolution_rate' => $total > 0 ? round((($resolved + $closed) / $total) * 100, 1) : 0,
        ];
    }

    /**
     * @return array<string, int>
     */
    public function categoryStatistics(string $startDate, string $endDate): array
    {
        return $this->groupedTicketCounts($startDate, $endDate, 'category');
    }

    /**
     * @return array<string, int>
     */
    public function priorityStatistics(string $startDate, string $endDate): array
    {
        return $this->groupedTicketCounts($startDate, $endDate, 'priority');
    }

    /**
     * @return array<int, array{name: string, total: int}>
     */
    public function topReporters(string $startDate, string $endDate): array
    {
        return Ticket::whereBetween('tickets.created_at', $this->dateRange($startDate, $endDate))
            ->join('users', 'tickets.user_id', '=', 'users.id')
            ->selectRaw('users.name, count(*) as total')
            ->groupBy('users.id', 'users.name')
            ->orderByDesc('total')
            ->limit(5)
            ->get()
            ->toArray();
    }

    /**
     * @return array<int, array{name: string, total: int}>
     */
    public function topHandlers(string $startDate, string $endDate): array
    {
        return Ticket::whereBetween('tickets.created_at', $this->dateRange($startDate, $endDate))
            ->whereNotNull('assigned_to')
            ->join('users', 'tickets.assigned_to', '=', 'users.id')
            ->selectRaw('users.name, count(*) as total')
            ->groupBy('users.id', 'users.name')
            ->orderByDesc('total')
            ->limit(5)
            ->get()
            ->toArray();
    }

    public function agentWorkload(): EloquentCollection
    {
        return User::role('Admin')
            ->withCount([
                'assignedTickets as active_tickets' => fn ($query) => $query->whereIn('status', TicketStatus::openValues()),
            ])
            ->orderByDesc('active_tickets')
            ->get(['id', 'name']);
    }

    /**
     * @return EloquentCollection<int, Ticket>
     */
    public function tickets(string $startDate, string $endDate): EloquentCollection
    {
        return $this->ticketsQuery($startDate, $endDate)->get();
    }

    /**
     * @return LazyCollection<int, Ticket>
     */
    public function lazyTickets(string $startDate, string $endDate, int $chunkSize = 500): LazyCollection
    {
        return $this->ticketsQuery($startDate, $endDate)->lazy($chunkSize);
    }

    public function categoryLabel(string $category): string
    {
        return TicketCategory::tryLabel($category) ?? $category;
    }

    public function priorityLabel(string $priority): string
    {
        return TicketPriority::tryLabel($priority) ?? $priority;
    }

    public function statusLabel(string $status): string
    {
        return TicketStatus::tryLabel($status) ?? $status;
    }

    /**
     * @return array<int, Carbon>
     */
    private function dateRange(string $startDate, string $endDate): array
    {
        return [
            Carbon::parse($startDate)->startOfDay(),
            Carbon::parse($endDate)->endOfDay(),
        ];
    }

    /**
     * @return Builder<Ticket>
     */
    private function ticketsQuery(string $startDate, string $endDate): Builder
    {
        return Ticket::with(['user', 'assignedTo'])
            ->whereBetween('created_at', $this->dateRange($startDate, $endDate))
            ->orderBy('created_at', 'desc');
    }

    private function averageDuration(string $startDate, string $endDate, string $resolvedColumn, string $unit): float|int|null
    {
        $expression = $this->durationAverageExpression($resolvedColumn, $unit);

        return Ticket::whereBetween('created_at', $this->dateRange($startDate, $endDate))
            ->whereNotNull($resolvedColumn)
            ->selectRaw("{$expression} as average_duration")
            ->value('average_duration');
    }

    private function durationAverageExpression(string $resolvedColumn, string $unit): string
    {
        $driver = DB::connection()->getDriverName();

        if ($driver === 'sqlite') {
            $multiplier = $unit === 'minute' ? '24 * 60' : '1';

            return "AVG((julianday({$resolvedColumn}) - julianday(created_at)) * {$multiplier})";
        }

        $mysqlUnit = $unit === 'minute' ? 'MINUTE' : 'DAY';

        return "AVG(TIMESTAMPDIFF({$mysqlUnit}, created_at, {$resolvedColumn}))";
    }

    /**
     * @return array<string, int>
     */
    private function groupedTicketCounts(string $startDate, string $endDate, string $column): array
    {
        return Ticket::whereBetween('created_at', $this->dateRange($startDate, $endDate))
            ->selectRaw("{$column}, count(*) as total")
            ->groupBy($column)
            ->pluck('total', $column)
            ->all();
    }
}
