<?php

namespace App\Filament\Resources\TicketResource\Pages;

use App\Filament\Resources\TicketResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;
use Illuminate\Support\Facades\Storage;

class EditTicket extends EditRecord
{
    protected static string $resource = TicketResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make(),
            Actions\DeleteAction::make(),
        ];
    }

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }

    protected function getSavedNotificationTitle(): ?string
    {
        return 'Tiket berhasil diperbarui';
    }

    protected function afterSave(): void
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

                Storage::disk('public')->delete($filePath);
            }
        }
    }
}
