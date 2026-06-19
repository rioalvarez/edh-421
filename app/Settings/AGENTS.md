# Settings Agent Guide

Settings memakai Spatie Laravel Settings.

## Class Settings
- `KaidoSetting`: group `general`, konfigurasi situs seperti nama, login, SSO, registrasi
- `ModuleSettings`: group `modules`, toggle modul besar
- `NavigationSettings`: group `navigation`, toggle per menu/sub-menu
- `SlaSettings`: group `sla`, konfigurasi SLA tiket

## Tambah Setting Baru
Checklist:
1. Tambah property di class settings yang sesuai.
2. Buat migration di `database/settings/`.
3. Gunakan key sesuai group.
4. Jalankan migration dengan `--force`.
5. Clear cache.

Contoh property:
```php
public bool $show_inventory_devices;
```

Contoh migration settings:
```php
$this->migrator->add('navigation.show_inventory_devices', true);
```

Command:
```powershell
php artisan migrate --force
php artisan optimize:clear
```

## Aturan Naming
Module toggle:
```text
enable_<module>
```

Navigation toggle:
```text
show_<module>_<menu>
```

Contoh:
```text
enable_inventory
show_inventory_devices
```

## Penting
- Jangan hapus property tanpa migration drop.
- Spatie settings memvalidasi schema terhadap property saat boot.
- Setelah ubah settings, selalu jalankan `php artisan optimize:clear`.
- Jika setting dipakai untuk sidebar/dashboard, tambahkan mapping di `app/Filament/Support/ModuleNavigationRegistry.php`.
- Resource/Page pakai `HasModuleNavigationGate`.
- Widget pakai `HasModuleWidgetGate`.
- Jangan cek manual `ModuleSettings` dan `NavigationSettings` berulang di Resource/Page/Widget baru.
