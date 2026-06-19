<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Tables\Concerns;

use App\Enums\VehicleBookingStatus;
use Filament\Forms;
use Filament\Tables;
use Illuminate\Database\Eloquent\Builder;

class VehicleBookingFilters
{
    public static function make(): array
    {
        return [
            Tables\Filters\SelectFilter::make('status')
                ->label('Status')
                ->options(VehicleBookingStatus::options()),

            Tables\Filters\SelectFilter::make('vehicle_id')
                ->label('Kendaraan')
                ->relationship('vehicle', 'plate_number')
                ->searchable()
                ->preload(),

            Tables\Filters\Filter::make('needs_return')
                ->label('Perlu Dikembalikan')
                ->query(fn (Builder $query) => $query
                    ->whereIn('status', VehicleBookingStatus::activeValues())
                    ->where('end_date', '<', today())
                    ->whereNull('returned_at'))
                ->toggle(),

            Tables\Filters\Filter::make('date_range')
                ->form([
                    Forms\Components\DatePicker::make('from')
                        ->label('Dari Tanggal'),
                    Forms\Components\DatePicker::make('until')
                        ->label('Sampai Tanggal'),
                ])
                ->query(function (Builder $query, array $data): Builder {
                    return $query
                        ->when(
                            $data['from'],
                            fn (Builder $query, $date): Builder => $query->where('start_date', '>=', $date),
                        )
                        ->when(
                            $data['until'],
                            fn (Builder $query, $date): Builder => $query->where('end_date', '<=', $date),
                        );
                }),
        ];
    }
}
