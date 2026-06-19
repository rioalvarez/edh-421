<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Tables\Concerns;

use App\Enums\FuelLevel;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource;
use App\Models\VehicleBooking;
use Filament\Forms;
use Filament\Notifications\Notification;
use Filament\Tables;

class VehicleBookingActions
{
    public static function rowActions(): array
    {
        return [
            Tables\Actions\Action::make('return')
                ->label('Kembalikan')
                ->icon('heroicon-o-arrow-uturn-left')
                ->color('success')
                ->form(fn (VehicleBooking $record) => self::returnForm($record))
                ->action(function (VehicleBooking $record, array $data) {
                    $record->markAsReturned($data);
                    Notification::make()
                        ->title('Kendaraan berhasil dikembalikan')
                        ->success()
                        ->send();
                    VehicleBookingResource::clearNavigationCache($record);
                })
                ->modalHeading('Pengembalian Kendaraan')
                ->modalDescription(fn (VehicleBooking $record) => $record->vehicleReturnDescription())
                ->modalSubmitActionLabel('Kembalikan Kendaraan')
                ->visible(fn (VehicleBooking $record) => $record->canBeReturned()),

            Tables\Actions\Action::make('cancel')
                ->label('Batalkan')
                ->icon('heroicon-o-x-circle')
                ->color('danger')
                ->form([
                    Forms\Components\Textarea::make('cancellation_reason')
                        ->label('Alasan Pembatalan')
                        ->required()
                        ->minLength(10)
                        ->maxLength(500)
                        ->rows(2)
                        ->placeholder('Jelaskan alasan pembatalan peminjaman...')
                        ->validationMessages([
                            'min' => 'Alasan pembatalan minimal 10 karakter',
                        ]),
                ])
                ->action(function (VehicleBooking $record, array $data) {
                    $record->cancel($data['cancellation_reason']);
                    Notification::make()
                        ->title('Peminjaman dibatalkan')
                        ->warning()
                        ->send();
                    VehicleBookingResource::clearNavigationCache($record);
                })
                ->modalHeading('Batalkan Peminjaman')
                ->modalDescription(fn (VehicleBooking $record) => "Apakah Anda yakin ingin membatalkan peminjaman {$record->booking_number}?")
                ->modalSubmitActionLabel('Ya, Batalkan')
                ->requiresConfirmation()
                ->visible(fn (VehicleBooking $record) => $record->canBeCancelled()),

            Tables\Actions\ViewAction::make(),
            Tables\Actions\EditAction::make()
                ->visible(fn (VehicleBooking $record) => $record->canBeEdited()),
            Tables\Actions\DeleteAction::make()
                ->visible(fn () => auth()->user()?->isItAdmin())
                ->after(fn () => VehicleBookingResource::clearNavigationCache()),
        ];
    }

    public static function bulkActions(): array
    {
        return [
            Tables\Actions\BulkActionGroup::make([
                Tables\Actions\DeleteBulkAction::make()
                    ->after(fn () => VehicleBookingResource::clearNavigationCache()),
            ]),
        ];
    }

    private static function returnForm(VehicleBooking $record): array
    {
        return [
            Forms\Components\Placeholder::make('start_odometer_info')
                ->label('KM Awal (Saat Berangkat)')
                ->content(fn () => $record->start_odometer ? number_format($record->start_odometer, 0, ',', '.').' km' : 'Tidak dicatat'),

            Forms\Components\TextInput::make('end_odometer')
                ->label('KM Akhir')
                ->integer()
                ->minValue(0)
                ->suffix('km')
                ->required()
                ->placeholder('Kilometer saat kembali')
                ->extraInputAttributes([
                    'onkeypress' => 'return (event.charCode >= 48 && event.charCode <= 57)',
                    'inputmode' => 'numeric',
                    'pattern' => '[0-9]*',
                ])
                ->rules([
                    fn () => function (string $attribute, $value, \Closure $fail) use ($record) {
                        if ($value < 0) {
                            $fail('KM Akhir tidak boleh negatif.');
                        }
                        if ($record->start_odometer && $value < $record->start_odometer) {
                            $fail("KM Akhir harus lebih besar dari KM Awal ({$record->start_odometer} km).");
                        }
                    },
                ])
                ->validationMessages([
                    'integer' => 'Hanya boleh diisi angka positif',
                ])
                ->helperText($record->start_odometer ? "Harus lebih besar dari KM Awal: {$record->start_odometer} km" : null),

            Forms\Components\Select::make('fuel_level')
                ->label('Level BBM')
                ->options(FuelLevel::options())
                ->required()
                ->native(false),

            Forms\Components\Select::make('return_condition')
                ->label('Kondisi Kendaraan')
                ->options([
                    'Baik, tidak ada kerusakan' => 'Baik, tidak ada kerusakan',
                    'Ada kerusakan ringan' => 'Ada kerusakan ringan',
                    'Ada kerusakan berat' => 'Ada kerusakan berat',
                    'Perlu perbaikan segera' => 'Perlu perbaikan segera',
                ])
                ->required()
                ->native(false),

            Forms\Components\Textarea::make('return_notes')
                ->label('Catatan Pengembalian')
                ->rows(2)
                ->maxLength(500)
                ->placeholder('Catatan tambahan saat pengembalian (opsional)'),
        ];
    }
}
