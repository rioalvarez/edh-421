<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

return new class extends SettingsMigration
{
    public function up(): void
    {
        // Halaman "Dashboard Perangkat" sudah dihapus; toggle ini tidak mengontrol apa pun lagi.
        $this->migrator->deleteIfExists('navigation.show_inventory_dashboard');
    }

    public function down(): void
    {
        $this->migrator->add('navigation.show_inventory_dashboard', true);
    }
};
