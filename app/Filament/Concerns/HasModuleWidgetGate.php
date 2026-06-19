<?php

namespace App\Filament\Concerns;

use App\Filament\Support\ModuleNavigationRegistry;

trait HasModuleWidgetGate
{
    protected static function passesModuleWidgetGate(): bool
    {
        $moduleNavigationKey = property_exists(static::class, 'moduleNavigationKey') ? static::$moduleNavigationKey : null;

        return ModuleNavigationRegistry::passes($moduleNavigationKey);
    }
}
