<?php

namespace App\Livewire;

use App\Models\Ticket;
use App\Models\TicketResponse;
use Livewire\Component;
use Filament\Notifications\Notification;

class TicketChat extends Component
{
    public Ticket $ticket;
    public string $message = '';

    public function mount(Ticket $ticket): void
    {
        $this->ticket = $ticket;
    }

    public function sendMessage(): void
    {
        $this->validate([
            'message' => 'required|min:3',
        ]);

        $this->ticket->responses()->create([
            'user_id' => auth()->id(),
            'message' => $this->message,
            'is_internal_note' => false,
        ]);

        // Update status jika admin merespon dan tiket masih open
        if (auth()->user()->hasRole('super_admin') && $this->ticket->status === 'open') {
            $this->ticket->update(['status' => 'in_progress']);
        }

        $this->message = '';

        Notification::make()
            ->title('Pesan terkirim')
            ->success()
            ->send();
    }

    public function render()
    {
        $responses = $this->ticket->responses()
            ->with('user')
            ->when(!auth()->user()->hasRole('super_admin'), function ($query) {
                $query->where('is_internal_note', false);
            })
            ->orderBy('created_at', 'asc')
            ->get();

        return view('livewire.ticket-chat', [
            'responses' => $responses,
        ]);
    }
}
