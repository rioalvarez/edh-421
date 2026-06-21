<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Tables\Concerns;

use App\Enums\TicketCategory;
use App\Enums\TicketPriority;
use App\Enums\TicketStatus;
use Filament\Tables;

class TicketColumns
{
    public static function make(): array
    {
        return [
            Tables\Columns\TextColumn::make('ticket_number')
                ->label('No. Tiket')
                ->searchable()
                ->sortable()
                ->copyable()
                ->weight('bold'),

            Tables\Columns\IconColumn::make('sla_status')
                ->label('SLA')
                ->state(function ($record) {
                    if (! $record || ! $record->sla_due_at || ! $record->isOpen()) {
                        return null;
                    }

                    return $record->isSlaOverdue() ? 'overdue' : 'ok';
                })
                ->icon(fn ($state) => match ($state) {
                    'overdue' => 'heroicon-s-exclamation-triangle',
                    'ok' => 'heroicon-s-check-circle',
                    default => null,
                })
                ->color(fn ($state) => match ($state) {
                    'overdue' => 'danger',
                    'ok' => 'success',
                    default => 'gray',
                })
                ->tooltip(fn ($record) => ($record && $record->sla_due_at)
                    ? 'Batas SLA: '.$record->sla_due_at->format('d M Y H:i')
                    : null
                ),

            Tables\Columns\TextColumn::make('subject')
                ->label('Subjek')
                ->searchable()
                ->limit(40)
                ->tooltip(fn ($record) => $record->subject),

            Tables\Columns\TextColumn::make('user.name')
                ->label('Pelapor')
                ->searchable()
                ->sortable(),

            Tables\Columns\TextColumn::make('category')
                ->label('Layanan')
                ->badge()
                ->formatStateUsing(fn ($state) => TicketCategory::tryLabel($state))
                ->color(fn (string $state): string => TicketCategory::tryColor($state)),

            Tables\Columns\TextColumn::make('priority')
                ->label('Prioritas')
                ->badge()
                ->formatStateUsing(fn ($state) => TicketPriority::tryLabel($state))
                ->color(fn (string $state): string => TicketPriority::tryColor($state)),

            Tables\Columns\TextColumn::make('status')
                ->label('Status')
                ->badge()
                ->formatStateUsing(fn ($state) => TicketStatus::tryLabel($state))
                ->color(fn (string $state): string => TicketStatus::tryColor($state)),

            Tables\Columns\TextColumn::make('assignedTo.name')
                ->label('Ditugaskan')
                ->default('-')
                ->searchable()
                ->toggleable(),

            Tables\Columns\TextColumn::make('device.hostname')
                ->label('Perangkat')
                ->default('-')
                ->toggleable(isToggledHiddenByDefault: true),

            Tables\Columns\TextColumn::make('created_at')
                ->label('Dibuat')
                ->dateTime('d M Y H:i')
                ->sortable()
                ->toggleable(),

            Tables\Columns\TextColumn::make('resolved_at')
                ->label('Diselesaikan')
                ->dateTime('d M Y H:i')
                ->sortable()
                ->toggleable(isToggledHiddenByDefault: true),

            Tables\Columns\TextColumn::make('rating.score')
                ->label('Rating')
                ->formatStateUsing(fn ($state) => $state ? str_repeat('⭐', $state) : '-')
                ->tooltip(fn ($record) => $record->rating?->feedback)
                ->sortable()
                ->toggleable(),
        ];
    }
}
