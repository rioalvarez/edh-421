<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceResource\Tables\Concerns;

use App\Filament\Exports\DeviceExporter;
use App\Filament\Imports\DeviceImporter;
use App\Filament\Modules\Inventaris\Resources\DeviceResource;
use App\Models\Device;
use Filament\Tables;
use Filament\Tables\Actions\ExportAction;
use Filament\Tables\Actions\ImportAction;

class DeviceActions
{
    public static function rowActions(): array
    {
        return [
            Tables\Actions\ViewAction::make()
                ->url(fn (Device $record): string => DeviceResource::getUrl('view', ['record' => $record])),
            Tables\Actions\EditAction::make(),
            Tables\Actions\DeleteAction::make(),
        ];
    }

    public static function headerActions(): array
    {
        return [
            ExportAction::make()
                ->exporter(DeviceExporter::class)
                ->label('Ekspor')
                ->icon('heroicon-o-arrow-down-tray'),
            ImportAction::make()
                ->importer(DeviceImporter::class)
                ->label('Impor')
                ->icon('heroicon-o-arrow-up-tray'),
        ];
    }

    public static function bulkActions(): array
    {
        return [
            Tables\Actions\BulkActionGroup::make([
                Tables\Actions\DeleteBulkAction::make(),
            ]),
        ];
    }
}
