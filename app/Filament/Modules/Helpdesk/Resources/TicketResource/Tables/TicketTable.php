<?php

namespace App\Filament\Modules\Helpdesk\Resources\TicketResource\Tables;

use App\Filament\Modules\Helpdesk\Resources\TicketResource\Tables\Concerns\TicketActions;
use App\Filament\Modules\Helpdesk\Resources\TicketResource\Tables\Concerns\TicketColumns;
use App\Filament\Modules\Helpdesk\Resources\TicketResource\Tables\Concerns\TicketFilters;
use Filament\Tables\Table;

class TicketTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns(TicketColumns::make())
            ->filters(TicketFilters::make())
            ->actions(TicketActions::rowActions())
            ->bulkActions(TicketActions::bulkActions())
            ->defaultSort('created_at', 'desc');
    }
}
