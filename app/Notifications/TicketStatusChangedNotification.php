<?php

namespace App\Notifications;

use App\Enums\TicketStatus;
use App\Filament\Modules\Helpdesk\Resources\TicketResource;
use App\Models\Ticket;
use Filament\Notifications\Actions\Action;
use Filament\Notifications\Notification as FilamentNotification;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Notification;

class TicketStatusChangedNotification extends Notification implements ShouldQueue
{
    use Queueable;

    public function __construct(
        private readonly int $ticketId,
        private readonly string $ticketNumber,
        private readonly string $newStatusLabel,
        private readonly string $newStatusColor,
    ) {}

    /**
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['database'];
    }

    /**
     * @return array<string, mixed>
     */
    public function toDatabase(object $notifiable): array
    {
        return FilamentNotification::make()
            ->title('Status Tiket Diperbarui')
            ->body("Tiket {$this->ticketNumber} status berubah menjadi: {$this->newStatusLabel}")
            ->icon('heroicon-o-arrow-path')
            ->iconColor($this->newStatusColor)
            ->actions([
                Action::make('view')
                    ->label('Lihat Tiket')
                    ->url(TicketResource::getUrl('view', ['record' => $this->ticketId]))
                    ->markAsRead(),
            ])
            ->getDatabaseMessage();
    }

    public static function fromTicket(Ticket $ticket, string $newStatus): self
    {
        return new self(
            ticketId: $ticket->id,
            ticketNumber: $ticket->ticket_number,
            newStatusLabel: TicketStatus::tryLabel($newStatus) ?? $newStatus,
            newStatusColor: TicketStatus::tryColor($newStatus),
        );
    }
}
