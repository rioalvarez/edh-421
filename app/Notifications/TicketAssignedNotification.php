<?php

namespace App\Notifications;

use App\Filament\Modules\Helpdesk\Resources\TicketResource;
use App\Models\Ticket;
use Filament\Notifications\Actions\Action;
use Filament\Notifications\Notification as FilamentNotification;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Notification;

class TicketAssignedNotification extends Notification implements ShouldQueue
{
    use Queueable;

    public function __construct(
        private readonly int $ticketId,
        private readonly string $title,
        private readonly string $body,
        private readonly string $icon,
        private readonly string $iconColor,
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
            ->title($this->title)
            ->body($this->body)
            ->icon($this->icon)
            ->iconColor($this->iconColor)
            ->actions([
                Action::make('view')
                    ->label('Lihat Tiket')
                    ->url(TicketResource::getUrl('view', ['record' => $this->ticketId]))
                    ->markAsRead(),
            ])
            ->getDatabaseMessage();
    }

    public static function forAssignee(Ticket $ticket): self
    {
        return new self(
            ticketId: $ticket->id,
            title: 'Tiket Ditugaskan ke Anda',
            body: "Anda ditugaskan untuk menangani tiket: {$ticket->ticket_number}",
            icon: 'heroicon-o-user-plus',
            iconColor: 'warning',
        );
    }

    public static function forReporter(Ticket $ticket, string $assigneeName): self
    {
        return new self(
            ticketId: $ticket->id,
            title: 'Tiket Anda Sedang Ditangani',
            body: "Tiket {$ticket->ticket_number} sedang ditangani oleh {$assigneeName}",
            icon: 'heroicon-o-wrench-screwdriver',
            iconColor: 'success',
        );
    }
}
