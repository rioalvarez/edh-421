<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Tables\Concerns;

use App\Enums\TicketStatus;
use App\Models\Ticket;
use App\Models\User;
use Filament\Forms;
use Filament\Tables;
use Illuminate\Database\Eloquent\Collection;

class TicketActions
{
    public static function rowActions(): array
    {
        return [
            Tables\Actions\Action::make('assign')
                ->label('Tugaskan')
                ->icon('heroicon-o-user-plus')
                ->color('warning')
                ->form([
                    Forms\Components\Select::make('assigned_to')
                        ->label('Tugaskan Ke')
                        ->options(fn () => self::adminOptions())
                        ->required(),
                ])
                ->action(function (Ticket $record, array $data) {
                    $record->update([
                        'assigned_to' => $data['assigned_to'],
                        'status' => TicketStatus::InProgress->value,
                    ]);
                })
                ->visible(fn (Ticket $record) => $record->status === TicketStatus::Open->value && auth()->user()->isItAdmin()),

            Tables\Actions\Action::make('resolve')
                ->label('Selesaikan')
                ->icon('heroicon-o-check-circle')
                ->color('success')
                ->form([
                    Forms\Components\Textarea::make('resolution_notes')
                        ->label('Catatan Penyelesaian')
                        ->required()
                        ->rows(3),
                ])
                ->action(function (Ticket $record, array $data) {
                    $record->markAsResolved($data['resolution_notes']);
                })
                ->visible(fn (Ticket $record) => in_array($record->status, TicketStatus::openValues(), true) && auth()->user()->isItAdmin()),

            Tables\Actions\Action::make('close')
                ->label('Tutup')
                ->icon('heroicon-o-x-circle')
                ->color('gray')
                ->requiresConfirmation()
                ->action(fn (Ticket $record) => $record->close())
                ->visible(fn (Ticket $record) => $record->status === TicketStatus::Resolved->value && auth()->user()->isItAdmin()),

            Tables\Actions\Action::make('reopen')
                ->label('Buka Kembali')
                ->icon('heroicon-o-arrow-path')
                ->color('warning')
                ->requiresConfirmation()
                ->modalHeading('Buka Kembali Tiket?')
                ->modalDescription('Tiket akan dikembalikan ke antrian dan dapat ditangani kembali.')
                ->modalSubmitActionLabel('Ya, Buka Kembali')
                ->action(fn (Ticket $record) => $record->reopen())
                ->visible(fn (Ticket $record) => $record->status === TicketStatus::Closed->value
                    && (
                        auth()->user()->isItAdmin()
                        || $record->user_id === auth()->id()
                    )
                ),

            Tables\Actions\ViewAction::make(),
            Tables\Actions\EditAction::make()
                ->visible(fn () => auth()->user()->isItAdmin()),
            Tables\Actions\DeleteAction::make()
                ->visible(fn () => auth()->user()->isItAdmin()),
        ];
    }

    public static function bulkActions(): array
    {
        return [
            Tables\Actions\BulkActionGroup::make([
                Tables\Actions\BulkAction::make('bulk_assign')
                    ->label('Tugaskan ke Admin')
                    ->icon('heroicon-o-user-plus')
                    ->color('warning')
                    ->form([
                        Forms\Components\Select::make('assigned_to')
                            ->label('Tugaskan Ke')
                            ->options(fn () => self::adminOptions())
                            ->required(),
                    ])
                    ->action(function (Collection $records, array $data) {
                        $records->each(function (Ticket $ticket) use ($data) {
                            $ticket->update([
                                'assigned_to' => $data['assigned_to'],
                                'status' => $ticket->status === TicketStatus::Open->value ? TicketStatus::InProgress->value : $ticket->status,
                            ]);
                        });
                    })
                    ->deselectRecordsAfterCompletion()
                    ->visible(fn () => auth()->user()->isItAdmin()),

                Tables\Actions\BulkAction::make('bulk_change_status')
                    ->label('Ubah Status')
                    ->icon('heroicon-o-arrow-path')
                    ->color('info')
                    ->form([
                        Forms\Components\Select::make('status')
                            ->label('Status Baru')
                            ->options(TicketStatus::options())
                            ->required(),
                    ])
                    ->action(function (Collection $records, array $data) {
                        $records->each(function (Ticket $ticket) use ($data) {
                            $updates = ['status' => $data['status']];

                            if ($data['status'] === TicketStatus::Resolved->value && ! $ticket->resolved_at) {
                                $updates['resolved_at'] = now();
                            }

                            if ($data['status'] === TicketStatus::Closed->value && ! $ticket->closed_at) {
                                $updates['closed_at'] = now();
                            }

                            $ticket->update($updates);
                        });
                    })
                    ->deselectRecordsAfterCompletion()
                    ->visible(fn () => auth()->user()->isItAdmin()),

                Tables\Actions\BulkAction::make('bulk_close')
                    ->label('Tutup Tiket')
                    ->icon('heroicon-o-x-circle')
                    ->color('gray')
                    ->requiresConfirmation()
                    ->modalHeading('Tutup tiket terpilih?')
                    ->modalDescription('Semua tiket yang dipilih akan ditutup.')
                    ->action(function (Collection $records) {
                        $records->each(fn (Ticket $ticket) => $ticket->close());
                    })
                    ->deselectRecordsAfterCompletion()
                    ->visible(fn () => auth()->user()->isItAdmin()),

                Tables\Actions\DeleteBulkAction::make(),
            ]),
        ];
    }

    private static function adminOptions()
    {
        return User::role('Admin')
            ->withCount(['assignedTickets as active_tickets' => fn ($query) => $query->whereIn('status', TicketStatus::openValues()),
            ])
            ->get()
            ->mapWithKeys(fn ($user) => [$user->id => "{$user->name} ({$user->active_tickets} aktif)"]);
    }
}
