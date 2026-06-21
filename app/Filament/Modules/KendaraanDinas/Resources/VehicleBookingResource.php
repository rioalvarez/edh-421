<?php

namespace App\Filament\Modules\KendaraanDinas\Resources;

use App\Enums\VehicleBookingStatus;
use App\Filament\Concerns\HasModuleNavigationGate;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Pages;
use App\Models\User;
use App\Models\VehicleBooking;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms\Form;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Cache;

class VehicleBookingResource extends Resource implements HasShieldPermissions
{
    use HasModuleNavigationGate;

    protected static ?string $model = VehicleBooking::class;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::VEHICLES_BOOKINGS;

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-list';

    protected static ?string $navigationGroup = 'Kendaraan Dinas';

    protected static ?int $navigationSort = 2;

    protected static ?string $navigationLabel = 'Peminjaman KDO';

    protected static ?string $modelLabel = 'Peminjaman';

    protected static ?string $pluralModelLabel = 'Peminjaman KDO';

    public static function getEloquentQuery(): Builder
    {
        $query = parent::getEloquentQuery()
            ->with(['user', 'vehicle']); // Eager loading untuk performa

        if (auth()->user()?->isItAdmin() !== true) {
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
            'return',
        ];
    }

    public static function clearNavigationCache(?VehicleBooking $booking = null): void
    {
        $userIds = collect([
            auth()->id(),
            $booking?->user_id,
        ]);

        // Use cached admin IDs to avoid querying users table every time
        $adminIds = Cache::remember('it_admin_ids', now()->addMinutes(10), function () {
            return User::itAdmins()->pluck('id')->all();
        });

        foreach ($adminIds as $id) {
            $userIds->push($id);
        }

        $keysToForget = [];

        $userIds
            ->filter()
            ->unique()
            ->each(function ($userId) use (&$keysToForget): void {
                foreach (['admin', 'user'] as $scope) {
                    $keysToForget[] = "booking_badge_{$userId}_{$scope}";
                    $keysToForget[] = "booking_badge_color_{$userId}_{$scope}";
                    $keysToForget[] = "vehicle_booking_stats_{$userId}_{$scope}";
                }
            });

        foreach ($keysToForget as $key) {
            Cache::forget($key);
        }
    }

    public static function getNavigationBadge(): ?string
    {
        $userId = auth()->id();
        $isAdmin = auth()->user()?->isItAdmin() ?? false;
        $cacheKey = "booking_badge_{$userId}_".($isAdmin ? 'admin' : 'user');

        return Cache::remember($cacheKey, now()->addMinutes(2), function () use ($isAdmin, $userId) {
            $query = static::getModel()::whereIn('status', VehicleBookingStatus::activeValues());

            if (! $isAdmin) {
                $query->where('user_id', $userId);
            }

            $count = $query->count();

            return $count > 0 ? (string) $count : null;
        });
    }

    public static function getNavigationBadgeColor(): ?string
    {
        $userId = auth()->id();
        $isAdmin = auth()->user()?->isItAdmin() ?? false;
        $cacheKey = "booking_badge_color_{$userId}_".($isAdmin ? 'admin' : 'user');

        return Cache::remember($cacheKey, now()->addMinutes(2), function () use ($isAdmin, $userId) {
            $query = static::getModel()::query()->needsReturn();

            if (! $isAdmin) {
                $query->where('user_id', $userId);
            }

            $count = $query->count();

            return $count > 0 ? 'danger' : 'success';
        });
    }

    public static function form(Form $form): Form
    {
        return \App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Schemas\VehicleBookingForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return \App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Tables\VehicleBookingTable::configure($table);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return \App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Infolists\VehicleBookingInfolist::configure($infolist);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListVehicleBookings::route('/'),
            'create' => Pages\CreateVehicleBooking::route('/create'),
            'view' => Pages\ViewVehicleBooking::route('/{record}'),
            'edit' => Pages\EditVehicleBooking::route('/{record}/edit'),
        ];
    }
}
