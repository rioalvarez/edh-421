<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

return new class extends SettingsMigration
{
    public function up(): void
    {
        // IT Helpdesk
        $this->migrator->add('navigation.show_helpdesk_tickets', true);
        $this->migrator->add('navigation.show_helpdesk_report', true);

        // Kendaraan Dinas
        $this->migrator->add('navigation.show_vehicle_master', true);
        $this->migrator->add('navigation.show_vehicle_booking', true);
        $this->migrator->add('navigation.show_vehicle_calendar', true);

        // Inventaris
        $this->migrator->add('navigation.show_inventory_devices', true);
        $this->migrator->add('navigation.show_inventory_dashboard', true);
        $this->migrator->add('navigation.show_inventory_attributes', true);
        $this->migrator->add('navigation.show_inventory_units', true);

        // Knowledge Management
        $this->migrator->add('navigation.show_km_articles', true);
        $this->migrator->add('navigation.show_km_categories', true);

        // Manajemen Pengguna
        $this->migrator->add('navigation.show_user_management', true);
        $this->migrator->add('navigation.show_role_management', true);
    }
};
