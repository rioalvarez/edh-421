<?php

namespace App\Filament\Imports;

use App\Models\Device;
use App\Models\User;
use Filament\Actions\Imports\ImportColumn;
use Filament\Actions\Imports\Importer;
use Filament\Actions\Imports\Models\Import;

class DeviceImporter extends Importer
{
    protected static ?string $model = Device::class;

    public static function getColumns(): array
    {
        return [
            ImportColumn::make('type')
                ->requiredMapping()
                ->rules(['required', 'in:laptop,desktop,all-in-one,workstation']),
            ImportColumn::make('assigned_to')
                ->label('Assigned To (User Email)')
                ->rules(['nullable', 'email']),
            ImportColumn::make('hostname')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('ip_address')
                ->label('IP Address')
                ->rules(['nullable', 'max:45']),
            ImportColumn::make('mac_address')
                ->label('MAC Address')
                ->rules(['nullable', 'max:17']),
            ImportColumn::make('brand')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('model')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('serial_number')
                ->label('Serial Number')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('asset_tag')
                ->label('Asset Tag')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('os')
                ->label('Operating System')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('os_version')
                ->label('OS Version')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('processor')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('ram')
                ->label('RAM')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('storage_type')
                ->label('Storage Type')
                ->rules(['nullable', 'in:SSD,HDD,NVMe,Hybrid']),
            ImportColumn::make('storage_capacity')
                ->label('Storage Capacity')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('condition')
                ->rules(['nullable', 'in:excellent,good,fair,poor,broken']),
            ImportColumn::make('status')
                ->rules(['nullable', 'in:active,inactive,maintenance,retired']),
            ImportColumn::make('location')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('purchase_date')
                ->label('Purchase Date')
                ->rules(['nullable', 'date']),
            ImportColumn::make('warranty_expiry')
                ->label('Warranty Expiry')
                ->rules(['nullable', 'date']),
            ImportColumn::make('notes')
                ->rules(['nullable']),
        ];
    }

    public function resolveRecord(): ?Device
    {
        // Check if device with same serial_number exists (update) or create new
        $device = null;

        if (!empty($this->data['serial_number'])) {
            $device = Device::where('serial_number', $this->data['serial_number'])->first();
        }

        if (!$device) {
            $device = new Device();
        }

        // Set default condition if not provided
        if (empty($this->data['condition'])) {
            $device->condition = 'good';
        }

        // Set default status if not provided
        if (empty($this->data['status'])) {
            $device->status = 'active';
        }

        // Handle user assignment by email
        if (!empty($this->data['assigned_to'])) {
            $user = User::where('email', $this->data['assigned_to'])->first();
            if ($user) {
                $device->user_id = $user->id;
            }
        }

        // Remove assigned_to from data as it's not a column in devices table
        unset($this->data['assigned_to']);

        return $device;
    }

    public static function getCompletedNotificationBody(Import $import): string
    {
        $body = 'Your device import has completed and ' . number_format($import->successful_rows) . ' ' . str('row')->plural($import->successful_rows) . ' imported.';

        if ($failedRowsCount = $import->getFailedRowsCount()) {
            $body .= ' ' . number_format($failedRowsCount) . ' ' . str('row')->plural($failedRowsCount) . ' failed to import.';
        }

        return $body;
    }
}
