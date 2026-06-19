<?php

namespace App\Filament\Concerns;

use App\Filament\Support\ModuleNavigationRegistry;
use App\Settings\ModuleSettings;
use App\Settings\NavigationSettings;

trait HasModuleNavigationGate
{
    public static function shouldRegisterNavigation(): bool
    {
        return static::passesModuleNavigationGate();
    }

    protected static function passesModuleNavigationGate(): bool
    {
        $moduleNavigationKey = property_exists(static::class, 'moduleNavigationKey') ? static::$moduleNavigationKey : null;

        if ($moduleNavigationKey) {
            return ModuleNavigationRegistry::passes($moduleNavigationKey);
        }

        $moduleSettingKey = property_exists(static::class, 'moduleSettingKey') ? static::$moduleSettingKey : null;
        $navigationSettingKey = property_exists(static::class, 'navigationSettingKey') ? static::$navigationSettingKey : null;

        if ($moduleSettingKey && ! (bool) app(ModuleSettings::class)->{$moduleSettingKey}) {
            return false;
        }

        if ($navigationSettingKey && ! (bool) app(NavigationSettings::class)->{$navigationSettingKey}) {
            return false;
        }

        return true;
    }
}
