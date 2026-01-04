<?php

namespace App\Filament\Resources\DeviceResource\Pages;

use App\Filament\Resources\DeviceResource;
use App\Models\DeviceAttribute;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditDevice extends EditRecord
{
    protected static string $resource = DeviceResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make(),
            Actions\DeleteAction::make(),
        ];
    }

    protected function mutateFormDataBeforeFill(array $data): array
    {
        // Load dynamic attributes values
        $dynamicAttributes = [];
        $attributes = DeviceAttribute::active()->ordered()->get();

        foreach ($attributes as $attribute) {
            $value = $this->record->attributeValues()
                ->where('device_attribute_id', $attribute->id)
                ->first();

            if ($value) {
                $dynamicAttributes[$attribute->slug] = $attribute->type === 'boolean'
                    ? (bool) $value->value
                    : $value->value;
            }
        }

        $data['dynamic_attributes'] = $dynamicAttributes;
        return $data;
    }

    protected function mutateFormDataBeforeSave(array $data): array
    {
        unset($data['dynamic_attributes']);
        return $data;
    }

    protected function afterSave(): void
    {
        $this->saveDynamicAttributes();
    }

    protected function saveDynamicAttributes(): void
    {
        $dynamicData = $this->data['dynamic_attributes'] ?? [];

        foreach ($dynamicData as $slug => $value) {
            $attribute = DeviceAttribute::where('slug', $slug)->first();
            if (!$attribute) {
                continue;
            }

            if ($value === null || $value === '') {
                // Delete if value is empty
                $this->record->attributeValues()
                    ->where('device_attribute_id', $attribute->id)
                    ->delete();
            } else {
                $this->record->attributeValues()->updateOrCreate(
                    ['device_attribute_id' => $attribute->id],
                    ['value' => is_bool($value) ? ($value ? '1' : '0') : (string) $value]
                );
            }
        }
    }

    public function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }
}
