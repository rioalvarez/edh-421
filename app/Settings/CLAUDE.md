# Spatie Laravel Settings

Instruksi utama ada di `app/Settings/AGENTS.md`. Ikuti file itu sebelum mengubah settings.

## Ringkasan Wajib
1. Tambah property di class settings yang sesuai.
2. Buat migration di `database/settings/`.
3. Gunakan key sesuai group, contoh `navigation.show_inventory_devices`.
4. Jalankan:
   ```powershell
   php artisan migrate --force
   php artisan optimize:clear
   ```

## Class yang Ada
- `KaidoSetting`: group `general`
- `ModuleSettings`: group `modules`
- `NavigationSettings`: group `navigation`
- `SlaSettings`: group `sla`

## Penting
- Jangan hapus property tanpa migration drop.
- Jika setting dipakai untuk sidebar/dashboard, tambahkan mapping di `app/Filament/Support/ModuleNavigationRegistry.php`.
- Resource/Page pakai `HasModuleNavigationGate`.
- Widget pakai `HasModuleWidgetGate`.
- Jangan membuat cek `ModuleSettings` dan `NavigationSettings` manual berulang di Resource/Page/Widget baru.
