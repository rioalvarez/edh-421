<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TicketResponse extends Model
{
    protected $guarded = ['id'];

    protected $casts = [
        'is_internal_note' => 'boolean',
    ];

    // Relationships
    public function ticket(): BelongsTo
    {
        return $this->belongsTo(Ticket::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    // Helper methods
    public function isFromAdmin(): bool
    {
        return $this->user->hasRole('super_admin');
    }

    public function isFromReporter(): bool
    {
        return $this->user_id === $this->ticket->user_id;
    }
}
