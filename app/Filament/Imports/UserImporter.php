<?php

namespace App\Filament\Imports;

use App\Models\User;
use Filament\Actions\Imports\ImportColumn;
use Filament\Actions\Imports\Importer;
use Filament\Actions\Imports\Models\Import;

class UserImporter extends Importer
{
    protected static ?string $model = User::class;

    public static function getColumns(): array
    {
        return [
            ImportColumn::make('name')
                ->label('Nama')
                ->requiredMapping()
                ->exampleHeader('Nama')
                ->example('Budi Santoso')
                ->helperText('Wajib. Nama lengkap pegawai, maks 255 karakter.')
                ->rules(['required', 'max:255']),
            ImportColumn::make('nip')
                ->label('NIP')
                ->requiredMapping()
                ->exampleHeader('NIP')
                ->example('198501234')
                ->helperText('Wajib. Tepat 9 digit angka, harus unik.')
                ->rules(['required', 'digits:9', 'unique:users,nip']),
            ImportColumn::make('phone_number')
                ->label('No. HP')
                ->exampleHeader('No. HP')
                ->example('081234567890')
                ->helperText('Opsional. Format 08xx atau 62xx, maks 20 karakter.')
                ->rules(['nullable', 'max:20']),
            ImportColumn::make('email')
                ->label('Email')
                ->exampleHeader('Email')
                ->example('budi.santoso@pajak.go.id')
                ->helperText('Opsional. Harus unik. Digunakan untuk login SSO.')
                ->rules(['nullable', 'email', 'max:255', 'unique:users,email']),
            ImportColumn::make('password')
                ->label('Password')
                ->exampleHeader('Password')
                ->example('Password123')
                ->helperText('Opsional. Jika kosong, user hanya bisa login via Google SSO.')
                ->rules(['nullable', 'max:255']),
        ];
    }

    public function resolveRecord(): ?User
    {
        return new User;
    }

    public static function getCompletedNotificationBody(Import $import): string
    {
        $body = 'Impor user telah selesai dan '.number_format($import->successful_rows).' baris berhasil diimpor.';

        if ($failedRowsCount = $import->getFailedRowsCount()) {
            $body .= ' '.number_format($failedRowsCount).' baris gagal diimpor.';
        }

        return $body;
    }
}
