<?php

namespace App\Filament\Modules\Helpdesk\Resources;

use App\Enums\TicketStatus;
use App\Filament\Concerns\HasModuleNavigationGate;
use App\Filament\Modules\Helpdesk\Resources\TicketResource\Pages;
use App\Filament\Modules\Helpdesk\Resources\TicketResource\RelationManagers;
use App\Models\Ticket;
use App\Models\User;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms\Form;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Cache;

class TicketResource extends Resource implements HasShieldPermissions
{
    use HasModuleNavigationGate;

    protected static ?string $model = Ticket::class;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::HELPDESK_TICKETS;

    protected static ?string $navigationIcon = 'heroicon-o-ticket';

    protected static ?string $navigationGroup = 'IT Helpdesk';

    protected static ?int $navigationSort = 1;

    protected static ?string $navigationLabel = 'Tiket';

    protected static ?string $modelLabel = 'Tiket';

    protected static ?string $pluralModelLabel = 'Tiket';

    // Scope: User biasa hanya lihat tiket sendiri, admin lihat semua
    public static function getEloquentQuery(): Builder
    {
        $query = parent::getEloquentQuery()
            ->with(['user', 'assignedTo', 'device', 'attachments']); // Eager loading untuk performa

        if (! auth()->user()->isItAdmin()) {
            $query->where('user_id', auth()->id());
        }

        return $query;
    }

    public static function getPermissionPrefixes(): array
    {
        return [
            'view',
            'view_any',
            'create',
            'update',
            'delete',
            'delete_any',
            'assign',
            'resolve',
        ];
    }

    public static function getNavigationBadge(): ?string
    {
        $userId = auth()->id();
        $isAdmin = auth()->user()->isItAdmin();
        $cacheKey = "ticket_badge_{$userId}_".($isAdmin ? 'admin' : 'user');

        return Cache::remember($cacheKey, now()->addMinutes(2), function () use ($isAdmin, $userId) {
            $query = static::getModel()::whereIn('status', [TicketStatus::Open->value, TicketStatus::InProgress->value]);

            if (! $isAdmin) {
                $query->where('user_id', $userId);
            }

            $count = $query->count();

            return $count ?: null;
        });
    }

    public static function getNavigationBadgeColor(): ?string
    {
        $userId = auth()->id();
        $isAdmin = auth()->user()->isItAdmin();
        $cacheKey = "ticket_badge_color_{$userId}_".($isAdmin ? 'admin' : 'user');

        return Cache::remember($cacheKey, now()->addMinutes(2), function () use ($isAdmin, $userId) {
            $query = static::getModel()::where('status', TicketStatus::Open->value);

            if (! $isAdmin) {
                $query->where('user_id', $userId);
            }

            $count = $query->count();

            return $count > 5 ? 'danger' : ($count > 0 ? 'warning' : 'success');
        });
    }

    public static function form(Form $form): Form
    {
        return \App\Filament\Modules\Helpdesk\Resources\TicketResource\Schemas\TicketForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return \App\Filament\Modules\Helpdesk\Resources\TicketResource\Tables\TicketTable::configure($table);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return \App\Filament\Modules\Helpdesk\Resources\TicketResource\Infolists\TicketInfolist::configure($infolist);
    }

    public static function getRelations(): array
    {
        return [
            // ResponsesRelationManager diganti dengan TicketChatWidget
            RelationManagers\AuditLogRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListTickets::route('/'),
            'select-service' => Pages\SelectTicketService::route('/select-service'),
            'create' => Pages\CreateTicket::route('/create'),
            'view' => Pages\ViewTicket::route('/{record}'),
            'edit' => Pages\EditTicket::route('/{record}/edit'),
        ];
    }
}
