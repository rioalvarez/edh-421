<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Pages;

use App\Enums\TicketStatus;
use App\Filament\Modules\Helpdesk\Resources\TicketResource;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;

class ViewTicket extends ViewRecord
{
    protected static string $resource = TicketResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\Action::make('takeOver')
                ->label('Ambil Alih')
                ->icon('heroicon-o-hand-raised')
                ->color('warning')
                ->requiresConfirmation()
                ->modalHeading('Ambil Alih Tiket?')
                ->modalDescription(function () {
                    $record = $this->getRecord();
                    if ($record->assigned_to && $record->assignedTo) {
                        return "Tiket ini sedang ditangani oleh {$record->assignedTo->name}. Anda akan mengambil alih penanganan tiket ini.";
                    }

                    return 'Anda akan ditugaskan sebagai penanggung jawab tiket ini.';
                })
                ->modalSubmitActionLabel('Ya, Ambil Alih')
                ->action(function () {
                    $record = $this->getRecord();
                    $updates = ['assigned_to' => auth()->id()];
                    if ($record->status === TicketStatus::Open->value) {
                        $updates['status'] = TicketStatus::InProgress->value;
                    }
                    $record->update($updates);
                    $this->refreshFormData(['assigned_to', 'status']);
                })
                ->visible(function () {
                    $record = $this->getRecord();

                    return auth()->user()->isItAdmin()
                        && $record->status !== TicketStatus::Closed->value
                        && $record->assigned_to !== auth()->id();
                }),

            Actions\Action::make('reopen')
                ->label('Buka Kembali')
                ->icon('heroicon-o-arrow-path')
                ->color('warning')
                ->requiresConfirmation()
                ->modalHeading('Buka Kembali Tiket?')
                ->modalDescription('Tiket akan dikembalikan ke antrian dan dapat ditangani kembali.')
                ->modalSubmitActionLabel('Ya, Buka Kembali')
                ->action(function () {
                    $this->getRecord()->reopen();
                    $this->refreshFormData(['status', 'resolved_at', 'closed_at']);
                })
                ->visible(fn () => $this->getRecord()->status === TicketStatus::Closed->value
                    && (
                        auth()->user()->isItAdmin()
                        || $this->getRecord()->user_id === auth()->id()  // pelapor bisa reopen tiket sendiri
                    )
                ),

            Actions\EditAction::make()
                ->visible(fn () => auth()->user()->isSuperAdmin()),
        ];
    }

    protected function getHeaderWidgets(): array
    {
        return [
            TicketResource\Widgets\TicketRatingWidget::class,
        ];
    }

    protected function getFooterWidgets(): array
    {
        return [
            TicketResource\Widgets\TicketChatWidget::class,
        ];
    }

    public function getFooterWidgetsColumns(): int|array
    {
        return 1;
    }
}
