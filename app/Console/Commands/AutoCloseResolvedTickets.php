<?php

namespace App\Console\Commands;

use App\Enums\TicketStatus;
use App\Models\Ticket;
use Illuminate\Console\Command;

class AutoCloseResolvedTickets extends Command
{
    /**
     * The name and signature of the console command.
     */
    protected $signature = 'tickets:auto-close {--days=3 : Days after resolved without rating}';

    /**
     * The console command description.
     */
    protected $description = 'Auto-close tickets that have been resolved for more than N days without a rating';

    /**
     * Execute the console command.
     */
    public function handle(): int
    {
        $days = (int) $this->option('days');

        $tickets = Ticket::where('status', TicketStatus::Resolved->value)
            ->where('resolved_at', '<=', now()->subDays($days))
            ->whereDoesntHave('rating')
            ->get();

        if ($tickets->isEmpty()) {
            $this->info('No tickets to auto-close.');

            return self::SUCCESS;
        }

        $count = 0;
        foreach ($tickets as $ticket) {
            $ticket->close();
            $count++;
        }

        $this->info("Auto-closed {$count} ticket(s) that were resolved for more than {$days} day(s) without rating.");

        return self::SUCCESS;
    }
}
