<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceResource\Tables\Concerns;

use App\Enums\DeviceCondition;
use App\Enums\DeviceStatus;
use App\Enums\DeviceType;
use App\Models\Device;
use Filament\Forms;
use Filament\Tables;
use Illuminate\Database\Eloquent\Builder;

class DeviceFilters
{
    public static function make(): array
    {
        return [
            self::textFilter('hostname', 'Hostname', 'Hostname', 'cari hostname...', 'hostname'),
            self::textFilter('ip_address', 'IP Address', 'IP Address', 'cth: 10.9.1', 'ip_address'),

            Tables\Filters\Filter::make('brand_model')
                ->label('Merek / Model')
                ->form([
                    Forms\Components\TextInput::make('value')
                        ->label('Merek atau Model')
                        ->placeholder('cth: Lenovo, OptiPlex')
                        ->live(debounce: 400),
                ])
                ->query(fn (Builder $query, array $data): Builder => $query
                    ->when($data['value'] ?? null, fn (Builder $q, $value) => $q->where(fn ($query) => $query
                        ->where('brand', 'like', "%{$value}%")
                        ->orWhere('model', 'like', "%{$value}%")))),

            Tables\Filters\Filter::make('serial_number')
                ->label('No. Seri / Tag Aset')
                ->form([
                    Forms\Components\TextInput::make('value')
                        ->label('No. Seri / Tag Aset')
                        ->placeholder('cth: SN-, AST-')
                        ->live(debounce: 400),
                ])
                ->query(fn (Builder $query, array $data): Builder => $query
                    ->when($data['value'] ?? null, fn (Builder $q, $value) => $q->where(fn ($query) => $query
                        ->where('serial_number', 'like', "%{$value}%")
                        ->orWhere('asset_tag', 'like', "%{$value}%")))),

            Tables\Filters\Filter::make('type')
                ->label('Tipe Perangkat')
                ->form([
                    Forms\Components\Radio::make('value')
                        ->label('Tipe Perangkat')
                        ->options(self::typeOptions())
                        ->default('all')
                        ->columns(2)
                        ->live(),
                ])
                ->query(fn (Builder $query, array $data): Builder => $query
                    ->when(
                        filled($data['value'] ?? null) && $data['value'] !== 'all',
                        fn (Builder $query) => $query->where('type', $data['value']),
                    ))
                ->indicateUsing(function (array $data): ?string {
                    $value = $data['value'] ?? 'all';

                    return ($value === 'all' || blank($value)) ? null : 'Tipe: '.DeviceType::tryLabel($value);
                }),

            Tables\Filters\SelectFilter::make('status')
                ->label('Status')
                ->options(DeviceStatus::options()),

            Tables\Filters\SelectFilter::make('condition')
                ->label('Kondisi')
                ->options(DeviceCondition::options()),

            Tables\Filters\SelectFilter::make('user_id')
                ->label('User')
                ->relationship('user', 'name')
                ->searchable()
                ->preload(),

            Tables\Filters\SelectFilter::make('location')
                ->label('Lokasi')
                ->options(fn () => Device::query()->pluck('location', 'location')->unique()->filter()->sort()),

            Tables\Filters\SelectFilter::make('unit_id')
                ->label('Unit Penanggung Jawab')
                ->relationship('unit', 'name')
                ->searchable()
                ->preload(),

            Tables\Filters\TernaryFilter::make('assigned')
                ->label('Status Penggunaan')
                ->placeholder('Semua')
                ->trueLabel('Digunakan')
                ->falseLabel('Belum Digunakan')
                ->queries(
                    true: fn ($query) => $query->whereNotNull('user_id'),
                    false: fn ($query) => $query->whereNull('user_id'),
                ),
        ];
    }

    private static function textFilter(string $name, string $label, string $inputLabel, string $placeholder, string $column)
    {
        return Tables\Filters\Filter::make($name)
            ->label($label)
            ->form([
                Forms\Components\TextInput::make('value')
                    ->label($inputLabel)
                    ->placeholder($placeholder)
                    ->live(debounce: 400),
            ])
            ->query(fn (Builder $query, array $data): Builder => $query
                ->when($data['value'] ?? null, fn (Builder $query, $value) => $query->where($column, 'like', "%{$value}%")));
    }

    private static function typeOptions(): array
    {
        return ['all' => 'Semua'] + DeviceType::options();
    }
}
