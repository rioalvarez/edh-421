<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Pages;

use App\Enums\TicketStatus;
use App\Filament\Modules\Helpdesk\Resources\TicketResource;
use Filament\Actions;
use Filament\Resources\Components\Tab;
use Filament\Resources\Pages\ListRecords;
use Illuminate\Database\Eloquent\Builder;

class ListTickets extends ListRecords
{
    protected static string $resource = TicketResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\Action::make('create')
                ->label('Rekam Tiket')
                ->icon('heroicon-o-plus')
                ->url(TicketResource::getUrl('select-service')),
        ];
    }

    public function getTabs(): array
    {
        $user = auth()->user();
        $isAdmin = $user->isItAdmin();

        // Helper untuk membuat query dengan filter user
        $getCount = function (string $status) use ($user, $isAdmin) {
            $query = \App\Models\Ticket::where('status', $status);
            if (! $isAdmin) {
                $query->where('user_id', $user->id);
            }

            return $query->count();
        };

        return [
            'all' => Tab::make('Semua'),
            TicketStatus::Open->value => Tab::make(TicketStatus::Open->label())
                ->modifyQueryUsing(fn (Builder $query) => $query->where('status', TicketStatus::Open->value))
                ->badge(fn () => $getCount(TicketStatus::Open->value))
                ->badgeColor(TicketStatus::Open->color()),
            TicketStatus::InProgress->value => Tab::make(TicketStatus::InProgress->label())
                ->modifyQueryUsing(fn (Builder $query) => $query->where('status', TicketStatus::InProgress->value))
                ->badge(fn () => $getCount(TicketStatus::InProgress->value))
                ->badgeColor(TicketStatus::InProgress->color()),
            TicketStatus::Resolved->value => Tab::make(TicketStatus::Resolved->label())
                ->modifyQueryUsing(fn (Builder $query) => $query->where('status', TicketStatus::Resolved->value))
                ->badge(fn () => $getCount(TicketStatus::Resolved->value))
                ->badgeColor(TicketStatus::Resolved->color()),
            TicketStatus::Closed->value => Tab::make(TicketStatus::Closed->label())
                ->modifyQueryUsing(fn (Builder $query) => $query->where('status', TicketStatus::Closed->value)),
        ];
    }
}
