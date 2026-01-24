<?php

namespace App\Filament\Resources\TicketResource\Pages;

use App\Filament\Resources\TicketResource;
use App\Models\TicketAttachment;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Support\Facades\Storage;

class CreateTicket extends CreateRecord
{
    protected static string $resource = TicketResource::class;

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }

    protected function getCreatedNotificationTitle(): ?string
    {
        return 'Tiket berhasil dibuat';
    }

    protected function afterCreate(): void
    {
        $attachments = $this->data['attachments'] ?? [];

        foreach ($attachments as $filePath) {
            if ($filePath && Storage::disk('public')->exists($filePath)) {
                $fileContent = Storage::disk('public')->get($filePath);
                $base64Data = base64_encode($fileContent);

                $this->record->attachments()->create([
                    'file_name' => basename($filePath),
                    'file_type' => Storage::disk('public')->mimeType($filePath),
                    'file_size' => Storage::disk('public')->size($filePath),
                    'file_data' => $base64Data,
                ]);

                // Hapus file dari storage karena sudah disimpan di database
                Storage::disk('public')->delete($filePath);
            }
        }
    }
}
