<?php

namespace App\Filament\Resources;

use App\Filament\Resources\VehicleBookingResource\Pages;
use App\Models\Vehicle;
use App\Models\VehicleBooking;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Cache;

class VehicleBookingResource extends Resource implements HasShieldPermissions
{
    protected static ?string $model = VehicleBooking::class;

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

        if (!auth()->user()->hasRole('super_admin')) {
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

    public static function getNavigationBadge(): ?string
    {
        $userId = auth()->id();
        $isAdmin = auth()->user()->hasRole('super_admin');
        $cacheKey = "booking_badge_{$userId}_" . ($isAdmin ? 'admin' : 'user');

        return Cache::remember($cacheKey, now()->addMinutes(2), function () use ($isAdmin, $userId) {
            $query = static::getModel()::whereIn('status', ['approved', 'in_use']);

            if (!$isAdmin) {
                $query->where('user_id', $userId);
            }

            $count = $query->count();
            return $count > 0 ? (string) $count : null;
        });
    }

    public static function getNavigationBadgeColor(): ?string
    {
        $userId = auth()->id();
        $isAdmin = auth()->user()->hasRole('super_admin');
        $cacheKey = "booking_badge_color_{$userId}_" . ($isAdmin ? 'admin' : 'user');

        return Cache::remember($cacheKey, now()->addMinutes(2), function () use ($isAdmin, $userId) {
            $query = static::getModel()::query()->needsReturn();

            if (!$isAdmin) {
                $query->where('user_id', $userId);
            }

            $count = $query->count();
            return $count > 0 ? 'danger' : 'success';
        });
    }

    public static function form(Form $form): Form
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
                            ->disabled(fn () => !auth()->user()->hasRole('super_admin'))
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
                            ->options(function () {
                                return Vehicle::active()
                                    ->get()
                                    ->mapWithKeys(fn ($v) => [
                                        $v->id => "{$v->plate_number} - {$v->brand} {$v->model} ({$v->capacity} org)"
                                    ]);
                            })
                            ->searchable()
                            ->preload()
                            ->required()
                            ->live()
                            ->afterStateUpdated(fn (Forms\Set $set) => $set('_check_trigger', now()->timestamp)),

                        Forms\Components\DatePicker::make('start_date')
                            ->label('Tanggal Mulai')
                            ->required()
                            ->minDate(today())
                            ->live()
                            ->afterStateUpdated(fn (Forms\Set $set) => $set('_check_trigger', now()->timestamp)),

                        Forms\Components\DatePicker::make('end_date')
                            ->label('Tanggal Selesai')
                            ->required()
                            ->minDate(fn (Forms\Get $get) => $get('start_date') ?? today())
                            ->live()
                            ->afterStateUpdated(fn (Forms\Set $set) => $set('_check_trigger', now()->timestamp))
                            ->rules([
                                fn (Forms\Get $get) => function (string $attribute, $value, \Closure $fail) use ($get) {
                                    $vehicleId = $get('vehicle_id');
                                    $startDate = $get('start_date');
                                    $recordId = $get('id');

                                    if ($vehicleId && $startDate && $value) {
                                        if (!VehicleBooking::isVehicleAvailable($vehicleId, $startDate, $value, $recordId)) {
                                            $fail('Kendaraan tidak tersedia pada tanggal tersebut. Silakan pilih tanggal lain.');
                                        }
                                    }
                                },
                            ]),

                        Forms\Components\TimePicker::make('departure_time')
                            ->label('Jam Keberangkatan')
                            ->seconds(false),

                        Forms\Components\Hidden::make('_check_trigger'),

                        // Real-time availability indicator
                        Forms\Components\Placeholder::make('availability_status')
                            ->label('Status Ketersediaan')
                            ->content(function (Forms\Get $get) {
                                $vehicleId = $get('vehicle_id');
                                $startDate = $get('start_date');
                                $endDate = $get('end_date');
                                $recordId = $get('id');

                                if (!$vehicleId || !$startDate || !$endDate) {
                                    return new \Illuminate\Support\HtmlString(
                                        '<div class="flex items-center gap-2 text-gray-500">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                            <span>Pilih kendaraan dan tanggal untuk cek ketersediaan</span>
                                        </div>'
                                    );
                                }

                                $isAvailable = VehicleBooking::isVehicleAvailable($vehicleId, $startDate, $endDate, $recordId);
                                $vehicle = Vehicle::find($vehicleId);

                                if ($isAvailable) {
                                    $startFormatted = \Carbon\Carbon::parse($startDate)->translatedFormat('d M Y');
                                    $endFormatted = \Carbon\Carbon::parse($endDate)->translatedFormat('d M Y');

                                    return new \Illuminate\Support\HtmlString(
                                        '<div class="flex items-center gap-2 text-success-600 dark:text-success-400 font-medium">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                            <span>Tersedia! ' . $vehicle->plate_number . ' dapat dipinjam pada ' . $startFormatted . ' - ' . $endFormatted . '</span>
                                        </div>'
                                    );
                                } else {
                                    // Get conflicting booking info
                                    $conflict = VehicleBooking::where('vehicle_id', $vehicleId)
                                        ->whereIn('status', ['approved', 'in_use'])
                                        ->where(function ($q) use ($startDate, $endDate) {
                                            $q->whereBetween('start_date', [$startDate, $endDate])
                                                ->orWhereBetween('end_date', [$startDate, $endDate])
                                                ->orWhere(function ($q2) use ($startDate, $endDate) {
                                                    $q2->where('start_date', '<=', $startDate)
                                                        ->where('end_date', '>=', $endDate);
                                                });
                                        })
                                        ->when($recordId, fn ($q) => $q->where('id', '!=', $recordId))
                                        ->with('user')
                                        ->first();

                                    $conflictInfo = $conflict
                                        ? "Sudah dibooking oleh {$conflict->user->name} ({$conflict->start_date->format('d M')} - {$conflict->end_date->format('d M')})"
                                        : "Kendaraan tidak tersedia pada tanggal tersebut";

                                    return new \Illuminate\Support\HtmlString(
                                        '<div class="flex items-center gap-2 text-danger-600 dark:text-danger-400 font-medium">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                            <span>' . $conflictInfo . '</span>
                                        </div>'
                                    );
                                }
                            })
                            ->columnSpanFull(),
                    ])->columns(2),

                Forms\Components\Section::make('Data Surat Tugas')
                    ->schema([
                        Forms\Components\TextInput::make('document_number')
                            ->label('Nomor Surat Tugas')
                            ->required()
                            ->maxLength(100)
                            ->placeholder('Contoh: ST-001/KPP/2024'),

                        Forms\Components\TextInput::make('destination')
                            ->label('Alamat Tujuan')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('Alamat lengkap tujuan dinas'),

                        Forms\Components\Textarea::make('purpose')
                            ->label('Keperluan/Tujuan Dinas')
                            ->required()
                            ->rows(2)
                            ->columnSpanFull()
                            ->placeholder('Jelaskan keperluan perjalanan dinas'),
                    ])->columns(2),

                Forms\Components\Section::make('Data Pengemudi & Penumpang')
                    ->schema([
                        Forms\Components\TextInput::make('driver_name')
                            ->label('Nama Pengemudi')
                            ->required()
                            ->maxLength(100)
                            ->placeholder('Nama lengkap pengemudi'),

                        Forms\Components\TextInput::make('driver_phone')
                            ->label('No. Telepon Pengemudi')
                            ->tel()
                            ->maxLength(20)
                            ->placeholder('Contoh: 08123456789'),

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
                            ->numeric()
                            ->suffix('km')
                            ->placeholder('Kilometer saat berangkat'),
                    ])
                    ->collapsible()
                    ->collapsed(),

                Forms\Components\Section::make('Catatan')
                    ->schema([
                        Forms\Components\Textarea::make('notes')
                            ->label('Catatan Tambahan')
                            ->rows(2)
                            ->columnSpanFull()
                            ->placeholder('Catatan tambahan (opsional)'),
                    ])->collapsible(),

                // Section untuk admin - status management
                Forms\Components\Section::make('Status Peminjaman')
                    ->schema([
                        Forms\Components\Select::make('status')
                            ->label('Status')
                            ->options([
                                'approved' => 'Disetujui',
                                'in_use' => 'Sedang Digunakan',
                                'completed' => 'Selesai',
                                'cancelled' => 'Dibatalkan',
                            ])
                            ->required()
                            ->default('in_use'),
                    ])
                    ->visible(fn () => auth()->user()->hasRole('super_admin'))
                    ->collapsed(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('booking_number')
                    ->label('No. Peminjaman')
                    ->searchable()
                    ->sortable()
                    ->weight('bold')
                    ->copyable(),

                Tables\Columns\TextColumn::make('user.name')
                    ->label('Pemohon')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('vehicle.plate_number')
                    ->label('No. Plat')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('vehicle.brand')
                    ->label('Kendaraan')
                    ->formatStateUsing(fn ($record) => "{$record->vehicle->brand} {$record->vehicle->model}")
                    ->toggleable(),

                Tables\Columns\TextColumn::make('destination')
                    ->label('Tujuan')
                    ->limit(30)
                    ->tooltip(fn ($record) => $record->destination)
                    ->searchable(),

                Tables\Columns\TextColumn::make('start_date')
                    ->label('Tgl Mulai')
                    ->date('d M Y')
                    ->sortable(),

                Tables\Columns\TextColumn::make('end_date')
                    ->label('Tgl Selesai')
                    ->date('d M Y')
                    ->sortable(),

                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->formatStateUsing(fn (string $state): string => match ($state) {
                        'approved' => 'Disetujui',
                        'in_use' => 'Sedang Digunakan',
                        'completed' => 'Selesai',
                        'cancelled' => 'Dibatalkan',
                        default => $state,
                    })
                    ->color(fn (string $state): string => match ($state) {
                        'approved' => 'info',
                        'in_use' => 'warning',
                        'completed' => 'success',
                        'cancelled' => 'danger',
                        default => 'gray',
                    }),

                Tables\Columns\IconColumn::make('needs_return')
                    ->label('Perlu Dikembalikan')
                    ->boolean()
                    ->state(fn ($record) => $record->needsReturn())
                    ->trueIcon('heroicon-o-exclamation-triangle')
                    ->trueColor('danger')
                    ->falseIcon('heroicon-o-check-circle')
                    ->falseColor('success')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Dibuat')
                    ->dateTime('d M Y H:i')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->label('Status')
                    ->options([
                        'approved' => 'Disetujui',
                        'in_use' => 'Sedang Digunakan',
                        'completed' => 'Selesai',
                        'cancelled' => 'Dibatalkan',
                    ]),

                Tables\Filters\SelectFilter::make('vehicle_id')
                    ->label('Kendaraan')
                    ->relationship('vehicle', 'plate_number')
                    ->searchable()
                    ->preload(),

                Tables\Filters\Filter::make('needs_return')
                    ->label('Perlu Dikembalikan')
                    ->query(fn (Builder $query) => $query->needsReturn())
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
            ])
            ->actions([
                Tables\Actions\Action::make('return')
                    ->label('Kembalikan')
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
                    ->action(function (VehicleBooking $record, array $data) {
                        $record->markAsReturned($data);
                        Notification::make()
                            ->title('Kendaraan berhasil dikembalikan')
                            ->success()
                            ->send();
                    })
                    ->visible(fn (VehicleBooking $record) => $record->canBeReturned()),

                Tables\Actions\Action::make('cancel')
                    ->label('Batalkan')
                    ->icon('heroicon-o-x-circle')
                    ->color('danger')
                    ->form([
                        Forms\Components\Textarea::make('cancellation_reason')
                            ->label('Alasan Pembatalan')
                            ->required()
                            ->rows(2),
                    ])
                    ->action(function (VehicleBooking $record, array $data) {
                        $record->cancel($data['cancellation_reason']);
                        Notification::make()
                            ->title('Peminjaman dibatalkan')
                            ->warning()
                            ->send();
                    })
                    ->visible(fn (VehicleBooking $record) => $record->canBeCancelled()),

                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make()
                    ->visible(fn (VehicleBooking $record) => $record->canBeEdited()),
                Tables\Actions\DeleteAction::make()
                    ->visible(fn () => auth()->user()->hasRole('super_admin')),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Section::make('Informasi Peminjaman')
                    ->schema([
                        TextEntry::make('booking_number')
                            ->label('Nomor Peminjaman')
                            ->weight('bold')
                            ->copyable(),
                        TextEntry::make('user.name')
                            ->label('Pemohon'),
                        TextEntry::make('status')
                            ->label('Status')
                            ->badge()
                            ->formatStateUsing(fn (string $state): string => match ($state) {
                                'approved' => 'Disetujui',
                                'in_use' => 'Sedang Digunakan',
                                'completed' => 'Selesai',
                                'cancelled' => 'Dibatalkan',
                                default => $state,
                            })
                            ->color(fn (string $state): string => match ($state) {
                                'approved' => 'info',
                                'in_use' => 'warning',
                                'completed' => 'success',
                                'cancelled' => 'danger',
                                default => 'gray',
                            }),
                        TextEntry::make('created_at')
                            ->label('Dibuat')
                            ->dateTime('d M Y H:i'),
                    ])->columns(4),

                Section::make('Data Kendaraan')
                    ->schema([
                        TextEntry::make('vehicle.plate_number')
                            ->label('Nomor Plat'),
                        TextEntry::make('vehicle.brand')
                            ->label('Merk'),
                        TextEntry::make('vehicle.model')
                            ->label('Model'),
                        TextEntry::make('vehicle.color')
                            ->label('Warna')
                            ->default('-'),
                    ])->columns(4),

                Section::make('Jadwal Perjalanan')
                    ->schema([
                        TextEntry::make('start_date')
                            ->label('Tanggal Mulai')
                            ->date('d M Y'),
                        TextEntry::make('end_date')
                            ->label('Tanggal Selesai')
                            ->date('d M Y'),
                        TextEntry::make('departure_time')
                            ->label('Jam Keberangkatan')
                            ->time('H:i')
                            ->placeholder('-'),
                        TextEntry::make('duration_days')
                            ->label('Durasi')
                            ->suffix(' hari'),
                    ])->columns(4),

                Section::make('Data Surat Tugas')
                    ->schema([
                        TextEntry::make('document_number')
                            ->label('Nomor Surat'),
                        TextEntry::make('destination')
                            ->label('Alamat Tujuan'),
                        TextEntry::make('purpose')
                            ->label('Keperluan')
                            ->columnSpanFull(),
                    ])->columns(2),

                Section::make('Data Pengemudi & Penumpang')
                    ->schema([
                        TextEntry::make('driver_name')
                            ->label('Nama Pengemudi'),
                        TextEntry::make('driver_phone')
                            ->label('No. Telepon')
                            ->default('-'),
                        TextEntry::make('passengers_list')
                            ->label('Daftar Penumpang')
                            ->columnSpanFull(),
                    ])->columns(2),

                Section::make('Data Odometer & BBM')
                    ->schema([
                        TextEntry::make('start_odometer')
                            ->label('KM Awal')
                            ->suffix(' km')
                            ->default('-'),
                        TextEntry::make('end_odometer')
                            ->label('KM Akhir')
                            ->suffix(' km')
                            ->default('-'),
                        TextEntry::make('distance_traveled')
                            ->label('Jarak Tempuh')
                            ->suffix(' km')
                            ->default('-'),
                        TextEntry::make('fuel_level')
                            ->label('Level BBM')
                            ->formatStateUsing(fn (?string $state): string => match ($state) {
                                'empty' => 'Kosong (E)',
                                'quarter' => '1/4',
                                'half' => '1/2',
                                'three_quarter' => '3/4',
                                'full' => 'Penuh (F)',
                                default => '-',
                            })
                            ->badge()
                            ->color(fn (?string $state): string => match ($state) {
                                'empty' => 'danger',
                                'quarter' => 'warning',
                                'half' => 'info',
                                'three_quarter' => 'success',
                                'full' => 'success',
                                default => 'gray',
                            }),
                    ])->columns(4)
                    ->visible(fn ($record) => $record->start_odometer || $record->end_odometer || $record->fuel_level),

                Section::make('Pengembalian')
                    ->schema([
                        TextEntry::make('returned_at')
                            ->label('Waktu Pengembalian')
                            ->dateTime('d M Y H:i')
                            ->placeholder('-'),
                        TextEntry::make('return_condition')
                            ->label('Kondisi Kendaraan')
                            ->default('-'),
                        TextEntry::make('return_notes')
                            ->label('Catatan Pengembalian')
                            ->default('-')
                            ->columnSpanFull(),
                    ])->columns(2)
                    ->visible(fn ($record) => $record->status === 'completed'),

                Section::make('Pembatalan')
                    ->schema([
                        TextEntry::make('cancellation_reason')
                            ->label('Alasan Pembatalan')
                            ->columnSpanFull(),
                    ])
                    ->visible(fn ($record) => $record->status === 'cancelled'),

                Section::make('Catatan')
                    ->schema([
                        TextEntry::make('notes')
                            ->label('Catatan Tambahan')
                            ->default('Tidak ada catatan')
                            ->columnSpanFull(),
                    ])
                    ->collapsible(),
            ]);
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
