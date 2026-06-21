<?php

namespace App\Filament\Imports;

use App\Enums\DeviceCondition;
use App\Enums\DeviceStatus;
use App\Enums\DeviceType;
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
                ->label('Tipe')
                ->requiredMapping()
                ->rules(['required', 'in:'.implode(',', DeviceType::computerValues())]),
            ImportColumn::make('assigned_to')
                ->label('User (Email User)')
                ->rules(['nullable', 'email', 'exists:users,email']),
            ImportColumn::make('hostname')
                ->label('Hostname')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('ip_address')
                ->label('Alamat IP')
                ->rules(['nullable', 'max:45']),
            ImportColumn::make('mac_address')
                ->label('Alamat MAC')
                ->rules(['nullable', 'max:17']),
            ImportColumn::make('brand')
                ->label('Merek')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('model')
                ->label('Model')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('serial_number')
                ->label('Nomor Seri')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('asset_tag')
                ->label('Tag Aset')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('os')
                ->label('Sistem Operasi')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('os_version')
                ->label('Versi OS')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('processor')
                ->label('Prosesor')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('ram')
                ->label('RAM')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('storage_type')
                ->label('Tipe Penyimpanan')
                ->rules(['nullable', 'in:SSD,HDD,NVMe,Hybrid']),
            ImportColumn::make('storage_capacity')
                ->label('Kapasitas Penyimpanan')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('condition')
                ->label('Kondisi')
                ->rules(['nullable', 'in:'.implode(',', array_keys(DeviceCondition::options()))]),
            ImportColumn::make('status')
                ->label('Status')
                ->rules(['nullable', 'in:'.implode(',', array_keys(DeviceStatus::options()))]),
            ImportColumn::make('location')
                ->label('Lokasi')
                ->rules(['nullable', 'max:255']),
            ImportColumn::make('purchase_date')
                ->label('Tanggal Pembelian')
                ->rules(['nullable', 'date']),
            ImportColumn::make('warranty_expiry')
                ->label('Masa Garansi Habis')
                ->rules(['nullable', 'date']),
            ImportColumn::make('notes')
                ->label('Catatan')
                ->rules(['nullable']),
        ];
    }

    public function resolveRecord(): ?Device
    {
        // Jika serial_number disertakan dan sudah ada di DB, update record tersebut
        $device = null;

        if (! empty($this->data['serial_number'])) {
            $device = Device::where('serial_number', $this->data['serial_number'])->first();
        }

        if (! $device) {
            $device = new Device;
        }

        // Validasi uniqueness asset_tag secara manual
        if (! empty($this->data['asset_tag'])) {
            $query = Device::where('asset_tag', $this->data['asset_tag']);
            if ($device->exists) {
                $query->where('id', '!=', $device->id);
            }
            if ($query->exists()) {
                throw new \Exception("Tag Aset '{$this->data['asset_tag']}' sudah digunakan oleh perangkat lain.");
            }
        }

        // Set default condition jika tidak disertakan
        if (empty($this->data['condition'])) {
            $device->condition = DeviceCondition::Good->value;
        }

        // Set default status jika tidak disertakan
        if (empty($this->data['status'])) {
            $device->status = DeviceStatus::Active->value;
        }

        // Assign user berdasarkan email
        if (! empty($this->data['assigned_to'])) {
            $user = User::where('email', $this->data['assigned_to'])->first();
            if ($user) {
                $device->user_id = $user->id;
            }
        }

        // Hapus assigned_to karena bukan kolom di tabel devices
        unset($this->data['assigned_to']);

        return $device;
    }

    public static function getCompletedNotificationBody(Import $import): string
    {
        $body = 'Impor perangkat telah selesai dan '.number_format($import->successful_rows).' baris berhasil diimpor.';

        if ($failedRowsCount = $import->getFailedRowsCount()) {
            $body .= ' '.number_format($failedRowsCount).' baris gagal diimpor.';
        }

        return $body;
    }
}
