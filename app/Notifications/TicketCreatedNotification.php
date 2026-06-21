<?php

namespace App\Notifications;

use App\Filament\Modules\Helpdesk\Resources\TicketResource;
use App\Models\Ticket;
use Filament\Notifications\Actions\Action;
use Filament\Notifications\Notification as FilamentNotification;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Notification;

class TicketCreatedNotification extends Notification implements ShouldQueue
{
    use Queueable;

    public function __construct(
        private readonly int $ticketId,
        private readonly string $ticketNumber,
        private readonly string $subject,
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
            ->title('Tiket Baru: '.$this->ticketNumber)
            ->body($this->subject)
            ->icon('heroicon-o-ticket')
            ->iconColor('info')
            ->actions([
                Action::make('view')
                    ->label('Lihat')
                    ->url(TicketResource::getUrl('view', ['record' => $this->ticketId]))
                    ->markAsRead(),
            ])
            ->getDatabaseMessage();
    }

    public static function fromTicket(Ticket $ticket): self
    {
        return new self(
            ticketId: $ticket->id,
            ticketNumber: $ticket->ticket_number,
            subject: $ticket->subject,
        );
    }
}
