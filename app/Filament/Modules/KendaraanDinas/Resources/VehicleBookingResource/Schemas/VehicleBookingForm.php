<?php

namespace App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Schemas;

use App\Enums\VehicleBookingStatus;
use App\Filament\Modules\KendaraanDinas\Resources\VehicleBookingResource\Support\VehicleBookingFormSupport;
use App\Models\VehicleBooking;
use Filament\Forms;
use Filament\Forms\Form;

class VehicleBookingForm
{
    public static function configure(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Data Peminjam')
                    ->schema([
                        Forms\Components\TextInput::make('booking_number')
                            ->label('Nomor Peminjaman')
                            ->disabled()
                            ->dehydrated(false)
                            ->visible(fn ($record) => $record !== null),

                        Forms\Components\Select::make('user_id')
                            ->label('Pemohon')
                            ->relationship('user', 'name')
                            ->searchable()
                            ->preload()
                            ->required()
                            ->default(fn () => auth()->id())
                            ->disabled(fn () => auth()->user()?->isItAdmin() !== true)
                            ->rules([
                                fn () => function (string $attribute, $value, \Closure $fail) {
                                    if (VehicleBooking::userHasUnreturnedBooking($value)) {
                                        $booking = VehicleBooking::getUserUnreturnedBooking($value);
                                        $fail("Pemohon masih memiliki peminjaman {$booking->booking_number} yang belum dikembalikan.");
                                    }
                                },
                            ])
                            ->helperText(function () {
                                if (VehicleBooking::userHasUnreturnedBooking(auth()->id())) {
                                    return 'Anda memiliki peminjaman yang belum dikembalikan!';
                                }

                                return null;
                            }),
                    ])->columns(2),

                Forms\Components\Section::make('Data Kendaraan & Jadwal')
                    ->schema([
                        Forms\Components\Select::make('vehicle_id')
                            ->label('Kendaraan')
                            ->options(fn () => VehicleBookingFormSupport::vehicleOptions())
                            ->searchable()
                            ->preload()
                            ->required()
                            ->live()
                            ->afterStateUpdated(fn (Forms\Set $set) => $set('_check_trigger', now()->timestamp)),

                        Forms\Components\DatePicker::make('start_date')
                            ->label('Tanggal Mulai')
                            ->required()
                            ->native()
                            ->minDate(today())
                            ->live()
                            ->afterStateUpdated(fn (Forms\Set $set) => $set('_check_trigger', now()->timestamp)),

                        Forms\Components\DatePicker::make('end_date')
                            ->label('Tanggal Selesai')
                            ->required()
                            ->native()
                            ->minDate(fn (Forms\Get $get) => $get('start_date') ?? today())
                            ->live()
                            ->afterStateUpdated(fn (Forms\Set $set) => $set('_check_trigger', now()->timestamp))
                            ->rules([
                                fn (Forms\Get $get) => function (string $attribute, $value, \Closure $fail) use ($get) {
                                    $vehicleId = $get('vehicle_id');
                                    $startDate = $get('start_date');
                                    $recordId = $get('id');
                                    $userId = $get('user_id');

                                    if ($vehicleId && $startDate && $value) {
                                        if (! VehicleBooking::isVehicleAvailable($vehicleId, $startDate, $value, $recordId)) {
                                            $fail('Kendaraan tidak tersedia pada tanggal tersebut. Silakan pilih tanggal lain.');
                                        }
                                    }

                                    // Block user dari meminjam lebih dari 1 KDO di hari yang sama
                                    if ($userId && $startDate && $value) {
                                        $hasOverlap = VehicleBooking::where('user_id', $userId)
                                            ->whereIn('status', \App\Enums\VehicleBookingStatus::activeValues())
                                            ->when($recordId, fn ($q) => $q->where('id', '!=', $recordId))
                                            ->where(function ($q) use ($startDate, $value) {
                                                $q->whereBetween('start_date', [$startDate, $value])
                                                    ->orWhereBetween('end_date', [$startDate, $value])
                                                    ->orWhere(function ($q2) use ($startDate, $value) {
                                                        $q2->where('start_date', '<=', $startDate)
                                                            ->where('end_date', '>=', $value);
                                                    });
                                            })
                                            ->exists();

                                        if ($hasOverlap) {
                                            $fail('Pemohon sudah memiliki peminjaman KDO lain pada tanggal tersebut. Tidak boleh meminjam lebih dari 1 kendaraan di hari yang sama.');
                                        }
                                    }
                                },
                            ]),

                        Forms\Components\Select::make('departure_time')
                            ->label('Jam Keberangkatan')
                            ->required()
                            ->options(self::hourOptions())
                            ->searchable()
                            ->helperText('Perkiraan waktu keberangkatan'),

                        Forms\Components\Hidden::make('_check_trigger'),

                        // Real-time availability indicator
                        Forms\Components\Placeholder::make('availability_status')
                            ->label('Status Ketersediaan')
                            ->content(fn (Forms\Get $get) => VehicleBookingFormSupport::availabilityStatus(
                                $get('vehicle_id'),
                                $get('start_date'),
                                $get('end_date'),
                                $get('id'),
                            ))
                            ->columnSpanFull(),
                    ])->columns(2),

                Forms\Components\Section::make('Data Surat Tugas')
                    ->schema([
                        Forms\Components\TextInput::make('document_number')
                            ->label('Nomor Surat Tugas')
                            ->required()
                            ->prefix('ST-')
                            ->suffix('/WPJ.09/KPP.0908/'.date('Y'))
                            ->placeholder('001')
                            ->maxLength(10)
                            ->regex('/^\d+$/')
                            ->extraInputAttributes([
                                'inputmode' => 'numeric',
                                'pattern' => '[0-9]*',
                            ])
                            ->helperText('Masukkan nomor urut surat tugas (contoh: 001, 002, dst)')
                            ->validationMessages([
                                'regex' => 'Hanya boleh diisi angka',
                            ])
                            ->dehydrateStateUsing(fn ($state) => $state ? 'ST-'.$state.'/WPJ.09/KPP.0908/'.date('Y') : null)
                            ->afterStateHydrated(function ($component, $state) {
                                if ($state && preg_match('/^ST-(\d+)\/WPJ\.09\/KPP\.0908\/\d{4}$/', $state, $matches)) {
                                    $component->state($matches[1]);
                                }
                            }),

                        Forms\Components\TextInput::make('destination')
                            ->label('Alamat Tujuan')
                            ->required()
                            ->minLength(5)
                            ->maxLength(255)
                            ->placeholder('Alamat lengkap tujuan dinas')
                            ->validationMessages([
                                'min' => 'Alamat tujuan minimal 5 karakter',
                            ]),

                        Forms\Components\Textarea::make('purpose')
                            ->label('Keperluan/Tujuan Dinas')
                            ->required()
                            ->minLength(10)
                            ->rows(2)
                            ->columnSpanFull()
                            ->placeholder('Jelaskan keperluan perjalanan dinas')
                            ->validationMessages([
                                'min' => 'Keperluan dinas minimal 10 karakter',
                            ]),
                    ])->columns(2),

                Forms\Components\Section::make('Data Pengemudi & Penumpang')
                    ->schema([
                        Forms\Components\TextInput::make('driver_name')
                            ->label('Nama Pengemudi')
                            ->required()
                            ->minLength(3)
                            ->maxLength(100)
                            ->placeholder('Nama lengkap pengemudi')
                            ->validationMessages([
                                'min' => 'Nama pengemudi minimal 3 karakter',
                            ]),

                        Forms\Components\TextInput::make('driver_phone')
                            ->label('No. Telepon Pengemudi')
                            ->tel()
                            ->minLength(10)
                            ->maxLength(15)
                            ->placeholder('Contoh: 08123456789')
                            ->regex('/^(08|62)[0-9]{8,13}$/')
                            ->validationMessages([
                                'regex' => 'Format nomor telepon tidak valid (contoh: 08123456789)',
                            ])
                            ->helperText('Format: 08XXXXXXXXXX atau 62XXXXXXXXXX'),

                        Forms\Components\TagsInput::make('passengers')
                            ->label('Daftar Penumpang')
                            ->placeholder('Ketik nama lalu tekan Enter')
                            ->helperText('Masukkan nama pegawai yang ikut serta')
                            ->columnSpanFull(),
                    ])->columns(2),

                Forms\Components\Section::make('Data Odometer (Opsional)')
                    ->schema([
                        Forms\Components\TextInput::make('start_odometer')
                            ->label('KM Awal')
                            ->integer()
                            ->minValue(0)
                            ->maxValue(9999999)
                            ->suffix('km')
                            ->placeholder('Kilometer saat berangkat')
                            ->extraInputAttributes([
                                'onkeypress' => 'return (event.charCode >= 48 && event.charCode <= 57)',
                                'inputmode' => 'numeric',
                                'pattern' => '[0-9]*',
                            ])
                            ->validationMessages([
                                'min' => 'KM Awal tidak boleh negatif',
                                'integer' => 'Hanya boleh diisi angka positif',
                            ]),
                    ])
                    ->collapsible()
                    ->collapsed(),

                Forms\Components\Section::make('Catatan')
                    ->schema([
                        Forms\Components\Textarea::make('notes')
                            ->label('Catatan Tambahan')
                            ->rows(2)
                            ->maxLength(500)
                            ->columnSpanFull()
                            ->placeholder('Catatan tambahan (opsional)'),
                    ])->collapsible(),

                // Section untuk admin - status management
                Forms\Components\Section::make('Status Peminjaman')
                    ->schema([
                        Forms\Components\Select::make('status')
                            ->label('Status')
                            ->options(VehicleBookingStatus::options())
                            ->required()
                            ->default(VehicleBookingStatus::InUse->value),
                    ])
                    ->visible(fn () => auth()->user()?->isItAdmin())
                    ->collapsed(),
            ]);
    }

    /**
     * Generate 24-hour time options (06:00 - 22:00, interval 30 menit).
     *
     * @return array<string, string>
     */
    private static function hourOptions(): array
    {
        $options = [];

        for ($hour = 6; $hour <= 22; $hour++) {
            foreach (['00', '30'] as $minute) {
                $time = sprintf('%02d:%s', $hour, $minute);
                $options[$time] = $time;
            }
        }

        return $options;
    }
}
