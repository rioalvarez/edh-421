<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Widgets;

use App\Enums\TicketStatus;
use App\Models\Ticket;
use App\Models\TicketRating;
use Filament\Notifications\Notification;
use Filament\Widgets\Widget;
use Illuminate\Database\Eloquent\Model;

class TicketRatingWidget extends Widget
{
    protected static string $view = 'filament.widgets.ticket-rating-widget';

    public ?Model $record = null;

    public int $score = 0;

    public string $feedback = '';

    protected int|string|array $columnSpan = 'full';

    public function submitRating(): void
    {
        /** @var Ticket $ticket */
        $ticket = $this->record;

        if (! $ticket->canBeRated()) {
            Notification::make()
                ->title('Rating tidak dapat diberikan')
                ->body('Tiket ini sudah dinilai atau statusnya sudah berubah.')
                ->danger()
                ->send();

            return;
        }

        if ($this->score < 1 || $this->score > 5) {
            Notification::make()
                ->title('Pilih rating')
                ->body('Silakan pilih bintang 1 sampai 5.')
                ->warning()
                ->send();

            return;
        }

        TicketRating::create([
            'ticket_id' => $ticket->id,
            'user_id' => auth()->id(),
            'score' => $this->score,
            'feedback' => trim($this->feedback) ?: null,
        ]);

        // Close the ticket after rating
        $ticket->close();

        Notification::make()
            ->title('Terima kasih atas penilaian Anda!')
            ->success()
            ->send();

        $this->redirect(request()->header('Referer', '/admin'));
    }

    public function setScore(int $value): void
    {
        $this->score = $value;
    }

    public static function canView(): bool
    {
        return true;
    }

    protected function shouldBeVisible(): bool
    {
        /** @var Ticket|null $ticket */
        $ticket = $this->record;

        if (! $ticket) {
            return false;
        }

        // Show rating form only to the ticket reporter when status is resolved
        if ($ticket->status === TicketStatus::Resolved->value
            && (int) $ticket->user_id === (int) auth()->id()
            && ! $ticket->hasBeenRated()) {
            return true;
        }

        // Show read-only rating if already rated
        if ($ticket->hasBeenRated()) {
            return true;
        }

        return false;
    }

    protected function getViewData(): array
    {
        /** @var Ticket|null $ticket */
        $ticket = $this->record;

        $canRate = false;
        $existingRating = null;

        if ($ticket instanceof Ticket) {
            $canRate = $ticket->canBeRated() && (int) $ticket->user_id === (int) auth()->id();
            $existingRating = $ticket->rating;
        }

        return [
            'visible' => $this->shouldBeVisible(),
            'canRate' => $canRate,
            'existingRating' => $existingRating,
        ];
    }
}
