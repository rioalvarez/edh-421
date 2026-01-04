<?php

namespace App\Filament\Exports;

use App\Models\Device;
use Filament\Actions\Exports\ExportColumn;
use Filament\Actions\Exports\Exporter;
use Filament\Actions\Exports\Models\Export;

class DeviceExporter extends Exporter
{
    protected static ?string $model = Device::class;

    public static function getColumns(): array
    {
        return [
            ExportColumn::make('id')
                ->label('ID'),
            ExportColumn::make('user.name')
                ->label('Assigned To'),
            ExportColumn::make('type'),
            ExportColumn::make('hostname'),
            ExportColumn::make('ip_address')
                ->label('IP Address'),
            ExportColumn::make('mac_address')
                ->label('MAC Address'),
            ExportColumn::make('brand'),
            ExportColumn::make('model'),
            ExportColumn::make('serial_number')
                ->label('Serial Number'),
            ExportColumn::make('asset_tag')
                ->label('Asset Tag'),
            ExportColumn::make('os')
                ->label('Operating System'),
            ExportColumn::make('os_version')
                ->label('OS Version'),
            ExportColumn::make('processor'),
            ExportColumn::make('ram')
                ->label('RAM'),
            ExportColumn::make('storage_type')
                ->label('Storage Type'),
            ExportColumn::make('storage_capacity')
                ->label('Storage Capacity'),
            ExportColumn::make('condition'),
            ExportColumn::make('status'),
            ExportColumn::make('location'),
            ExportColumn::make('purchase_date')
                ->label('Purchase Date'),
            ExportColumn::make('warranty_expiry')
                ->label('Warranty Expiry'),
            ExportColumn::make('notes'),
            ExportColumn::make('created_at'),
            ExportColumn::make('updated_at'),
        ];
    }

    public static function getCompletedNotificationBody(Export $export): string
    {
        $body = 'Your device export has completed and ' . number_format($export->successful_rows) . ' ' . str('row')->plural($export->successful_rows) . ' exported.';

        if ($failedRowsCount = $export->getFailedRowsCount()) {
            $body .= ' ' . number_format($failedRowsCount) . ' ' . str('row')->plural($failedRowsCount) . ' failed to export.';
        }

        return $body;
    }
}
