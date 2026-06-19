<?php

namespace App\Filament\Modules\Inventaris\Resources\DeviceResource\Schemas;

use App\Filament\Modules\Inventaris\Resources\DeviceResource\Schemas\Concerns\DeviceFormSections;
use Filament\Forms\Form;

class DeviceForm
{
    public static function configure(Form $form): Form
    {
        return $form->schema(DeviceFormSections::make());
    }
}
