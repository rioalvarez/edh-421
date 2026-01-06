<?php

namespace App\Filament\Resources\VehicleBookingResource\Pages;

use App\Filament\Resources\VehicleBookingResource;
use App\Models\VehicleBooking;
use Filament\Actions;
use Filament\Forms;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\ViewRecord;

class ViewVehicleBooking extends ViewRecord
{
    protected static string $resource = VehicleBookingResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\Action::make('start_use')
                ->label('Mulai Penggunaan')
                ->icon('heroicon-o-play')
                ->color('warning')
                ->requiresConfirmation()
                ->modalHeading('Mulai Penggunaan Kendaraan')
                ->modalDescription('Apakah Anda yakin ingin memulai penggunaan kendaraan ini?')
                ->action(function () {
                    $this->record->markAsInUse();
                    Notification::make()
                        ->title('Penggunaan dimulai')
                        ->success()
                        ->send();
                    $this->refreshFormData(['status']);
                })
                ->visible(fn () => $this->record->status === 'approved' && $this->record->start_date <= today()),

            Actions\Action::make('return')
                ->label('Kembalikan Kendaraan')
                ->icon('heroicon-o-arrow-uturn-left')
                ->color('success')
                ->form([
                    Forms\Components\TextInput::make('end_odometer')
                        ->label('KM Akhir')
                        ->numeric()
                        ->suffix('km')
                        ->required()
                        ->placeholder('Kilometer saat kembali'),

                    Forms\Components\Select::make('fuel_level')
                        ->label('Level BBM')
                        ->options([
                            'empty' => 'Kosong (E)',
                            'quarter' => '1/4',
                            'half' => '1/2',
                            'three_quarter' => '3/4',
                            'full' => 'Penuh (F)',
                        ])
                        ->required(),

                    Forms\Components\Select::make('return_condition')
                        ->label('Kondisi Kendaraan')
                        ->options([
                            'Baik, tidak ada kerusakan' => 'Baik, tidak ada kerusakan',
                            'Ada kerusakan ringan' => 'Ada kerusakan ringan',
                            'Ada kerusakan berat' => 'Ada kerusakan berat',
                            'Perlu perbaikan segera' => 'Perlu perbaikan segera',
                        ])
                        ->required(),

                    Forms\Components\Textarea::make('return_notes')
                        ->label('Catatan Pengembalian')
                        ->rows(2)
                        ->placeholder('Catatan tambahan saat pengembalian (opsional)'),
                ])
                ->action(function (array $data) {
                    $this->record->markAsReturned($data);
                    Notification::make()
                        ->title('Kendaraan berhasil dikembalikan')
                        ->success()
                        ->send();
                    $this->refreshFormData(['status', 'end_odometer', 'fuel_level', 'return_condition', 'return_notes', 'returned_at']);
                })
                ->visible(fn () => $this->record->canBeReturned()),

            Actions\Action::make('cancel')
                ->label('Batalkan')
                ->icon('heroicon-o-x-circle')
                ->color('danger')
                ->form([
                    Forms\Components\Textarea::make('cancellation_reason')
                        ->label('Alasan Pembatalan')
                        ->required()
                        ->rows(2),
                ])
                ->action(function (array $data) {
                    $this->record->cancel($data['cancellation_reason']);
                    Notification::make()
                        ->title('Peminjaman dibatalkan')
                        ->warning()
                        ->send();
                    $this->refreshFormData(['status', 'cancellation_reason']);
                })
                ->visible(fn () => $this->record->canBeCancelled()),

            Actions\EditAction::make()
                ->visible(fn () => $this->record->canBeEdited()),
        ];
    }
}
