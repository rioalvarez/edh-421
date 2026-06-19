<?php

namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class NavigationSettings extends Settings
{
    // IT Helpdesk
    public bool $show_helpdesk_tickets;

    public bool $show_helpdesk_report;

    // Kendaraan Dinas
    public bool $show_vehicle_master;

    public bool $show_vehicle_booking;

    public bool $show_vehicle_calendar;

    // Inventaris
    public bool $show_inventory_devices;

    public bool $show_inventory_attributes;

    public bool $show_inventory_units;

    // Knowledge Management
    public bool $show_km_articles;

    public bool $show_km_categories;

    // Manajemen User
    public bool $show_user_management;

    public bool $show_role_management;

    public static function group(): string
    {
        return 'navigation';
    }
}
