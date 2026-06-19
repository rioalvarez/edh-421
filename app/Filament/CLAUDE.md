# Filament Conventions

Instruksi utama untuk semua AI agent ada di:
- `AGENTS.md`
- `app/Filament/AGENTS.md`
- `app/Settings/AGENTS.md`

Ikuti file tersebut sebelum mengubah Resource, Page, Widget, policy, atau settings.

## Ringkasan Wajib
1. Semua Resource baru masuk ke `app/Filament/Modules/<Domain>/Resources`, bukan `app/Filament/Resources`.
2. Resource utama harus tipis dan delegasi ke:
   - `Schemas/<Name>Form.php`
   - `Tables/<Name>Table.php`
   - `Infolists/<Name>Infolist.php`
3. Table besar dipecah lagi ke:
   - `Tables/Concerns/<Name>Columns.php`
   - `Tables/Concerns/<Name>Filters.php`
   - `Tables/Concerns/<Name>Actions.php`
4. Navigation wajib memakai `HasModuleNavigationGate` dengan `$moduleNavigationKey` dari `ModuleNavigationRegistry`.
5. Widget wajib memakai `HasModuleWidgetGate` jika bergantung pada module/navigation gate.
6. Policy wajib memakai `HasSuperAdminBypass` dan `ChecksPolicyPermissions`.
6. Setelah menjalankan Shield, cek dan hapus placeholder `{{ ... }}` dari policy.

## Command Wajib
Setelah tambah/ubah Filament Resource, Page, atau Widget:
```powershell
php artisan shield:generate --all --panel=admin --no-interaction
php artisan optimize:clear
rg -n "\{\{ .* \}\}|App\\\\Policies|Illuminate\\\\Auth" app\Policies
```

Verifikasi:
```powershell
Get-ChildItem app -Recurse -Filter *.php | ForEach-Object { php -l $_.FullName }
php artisan test
```

Jika menyentuh Blade/CSS/Vite:
```powershell
npm run build
```

## Navigation Group
Navigasi domain tetap memakai sidebar `NavigationGroup` Filament yang collapsible.
Nama group resmi:
- `IT Helpdesk`
- `Kendaraan Dinas`
- `Inventaris`
- `Knowledge Management`
- `Manajemen User`
- `Pengaturan`

Jangan ubah string group tanpa audit penuh.

## Device Resource
List Device punya custom toolbar/render hook di `AdminPanelProvider`.
Jangan ubah render hook tersebut kecuali sedang mengerjakan halaman `/admin/devices`.
