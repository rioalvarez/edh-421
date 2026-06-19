<?php

namespace App\Filament\Support;

use App\Settings\ModuleSettings;
use App\Settings\NavigationSettings;

class ModuleNavigationRegistry
{
    public const HELPDESK_TICKETS = 'helpdesk.tickets';

    public const HELPDESK_REPORT = 'helpdesk.report';

    public const HELPDESK_SLA = 'helpdesk.sla';

    public const VEHICLES_MASTER = 'vehicles.master';

    public const VEHICLES_BOOKINGS = 'vehicles.bookings';

    public const VEHICLES_CALENDAR = 'vehicles.calendar';

    public const INVENTORY_DEVICES = 'inventory.devices';

    public const INVENTORY_ATTRIBUTES = 'inventory.attributes';

    public const INVENTORY_UNITS = 'inventory.units';

    public const KNOWLEDGE_ARTICLES = 'knowledge.articles';

    public const KNOWLEDGE_CATEGORIES = 'knowledge.categories';

    public const USERS_ACCOUNTS = 'users.accounts';

    public const USERS_ROLES = 'users.roles';

    /**
     * @return array<string, array{module: string, navigation: string}>
     */
    public static function entries(): array
    {
        return [
            self::HELPDESK_TICKETS => [
                'module' => 'enable_helpdesk_tickets',
                'navigation' => 'show_helpdesk_tickets',
            ],
            self::HELPDESK_REPORT => [
                'module' => 'enable_helpdesk_tickets',
                'navigation' => 'show_helpdesk_report',
            ],
            self::HELPDESK_SLA => [
                'module' => 'enable_helpdesk_tickets',
                'navigation' => 'show_helpdesk_tickets',
            ],

            self::VEHICLES_MASTER => [
                'module' => 'enable_vehicle_booking',
                'navigation' => 'show_vehicle_master',
            ],
            self::VEHICLES_BOOKINGS => [
                'module' => 'enable_vehicle_booking',
                'navigation' => 'show_vehicle_booking',
            ],
            self::VEHICLES_CALENDAR => [
                'module' => 'enable_vehicle_booking',
                'navigation' => 'show_vehicle_calendar',
            ],

            self::INVENTORY_DEVICES => [
                'module' => 'enable_inventory',
                'navigation' => 'show_inventory_devices',
            ],
            self::INVENTORY_ATTRIBUTES => [
                'module' => 'enable_inventory',
                'navigation' => 'show_inventory_attributes',
            ],
            self::INVENTORY_UNITS => [
                'module' => 'enable_inventory',
                'navigation' => 'show_inventory_units',
            ],

            self::KNOWLEDGE_ARTICLES => [
                'module' => 'enable_blog',
                'navigation' => 'show_km_articles',
            ],
            self::KNOWLEDGE_CATEGORIES => [
                'module' => 'enable_blog',
                'navigation' => 'show_km_categories',
            ],

            self::USERS_ACCOUNTS => [
                'module' => 'enable_user_management',
                'navigation' => 'show_user_management',
            ],
            self::USERS_ROLES => [
                'module' => 'enable_user_management',
                'navigation' => 'show_role_management',
            ],
        ];
    }

    public static function passes(?string $key): bool
    {
        if (! $key) {
            return true;
        }

        $entry = self::entries()[$key] ?? null;

        if (! $entry) {
            return false;
        }

        return self::moduleEnabled($entry['module'])
            && self::navigationEnabled($entry['navigation']);
    }

    public static function moduleKey(string $key): ?string
    {
        return self::entries()[$key]['module'] ?? null;
    }

    public static function navigationKey(string $key): ?string
    {
        return self::entries()[$key]['navigation'] ?? null;
    }

    private static function moduleEnabled(string $settingKey): bool
    {
        return (bool) app(ModuleSettings::class)->{$settingKey};
    }

    private static function navigationEnabled(string $settingKey): bool
    {
        return (bool) app(NavigationSettings::class)->{$settingKey};
    }
}
