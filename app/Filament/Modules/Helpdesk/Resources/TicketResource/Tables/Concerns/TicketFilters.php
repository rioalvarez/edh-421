<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Tables\Concerns;

use App\Enums\TicketCategory;
use App\Enums\TicketPriority;
use App\Enums\TicketStatus;
use Filament\Forms;
use Filament\Tables;
use Illuminate\Database\Eloquent\Builder;

class TicketFilters
{
    public static function make(): array
    {
        return [
            Tables\Filters\SelectFilter::make('status')
                ->label('Status')
                ->options(TicketStatus::options())
                ->multiple(),

            Tables\Filters\SelectFilter::make('priority')
                ->label('Prioritas')
                ->options(TicketPriority::options()),

            Tables\Filters\SelectFilter::make('category')
                ->label('Layanan')
                ->options(TicketCategory::serviceOptions()),

            Tables\Filters\SelectFilter::make('assigned_to')
                ->label('Ditugaskan Ke')
                ->relationship('assignedTo', 'name')
                ->searchable()
                ->preload(),

            Tables\Filters\SelectFilter::make('user_id')
                ->label('Pelapor')
                ->relationship('user', 'name')
                ->searchable()
                ->preload(),

            Tables\Filters\Filter::make('unassigned')
                ->label('Belum Ditugaskan')
                ->query(fn (Builder $query) => $query->whereNull('assigned_to'))
                ->toggle(),

            Tables\Filters\Filter::make('sla_overdue')
                ->label('SLA Terlampaui')
                ->query(fn (Builder $query) => $query
                    ->whereNotNull('sla_due_at')
                    ->where('sla_due_at', '<', now())
                    ->whereIn('status', TicketStatus::openValues())
                )
                ->toggle(),

            Tables\Filters\Filter::make('created_at')
                ->form([
                    Forms\Components\DatePicker::make('from')
                        ->label('Dari Tanggal'),
                    Forms\Components\DatePicker::make('until')
                        ->label('Sampai Tanggal'),
                ])
                ->query(function (Builder $query, array $data): Builder {
                    return $query
                        ->when(
                            $data['from'],
                            fn (Builder $query, $date): Builder => $query->whereDate('created_at', '>=', $date),
                        )
                        ->when(
                            $data['until'],
                            fn (Builder $query, $date): Builder => $query->whereDate('created_at', '<=', $date),
                        );
                }),
        ];
    }
}
