<?php

namespace App\Filament\Resources\TicketResource\Widgets;

use App\Models\Ticket;
use Filament\Widgets\Widget;
use Filament\Notifications\Notification;
use Illuminate\Database\Eloquent\Model;

class TicketChatWidget extends Widget
{
    protected static string $view = 'filament.resources.ticket-resource.widgets.ticket-chat-widget';

    protected int | string | array $columnSpan = 'full';

    public ?Model $record = null;

    public string $message = '';

    public function sendMessage(): void
    {
        $this->validate([
            'message' => 'required|min:3',
        ], [
            'message.required' => 'Pesan tidak boleh kosong',
            'message.min' => 'Pesan minimal 3 karakter',
        ]);

        $this->record->responses()->create([
            'user_id' => auth()->id(),
            'message' => nl2br(e($this->message)),
            'is_internal_note' => false,
        ]);

        // Update status jika admin merespon dan tiket masih open
        if (auth()->user()->hasRole('super_admin') && $this->record->status === 'open') {
            $this->record->update(['status' => 'in_progress']);
        }

        $this->message = '';

        Notification::make()
            ->title('Pesan terkirim')
            ->success()
            ->send();
    }

    protected function getViewData(): array
    {
        $responses = $this->record->responses()
            ->with('user')
            ->when(!auth()->user()->hasRole('super_admin'), function ($query) {
                $query->where('is_internal_note', false);
            })
            ->orderBy('created_at', 'asc')
            ->get();

        return [
            'responses' => $responses,
            'ticket' => $this->record,
        ];
    }
}
