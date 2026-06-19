# Paku-IT

Aplikasi IT internal: Helpdesk, Inventaris IT, KDO, dan Knowledge Management.

## Stack
- Laravel 12, Filament 3, MySQL (Laragon)
- Spatie: laravel-permission, laravel-settings
- BezhanSalleh FilamentShield
- Auth: Filament Breezy + Socialite Google SSO

## Lingkungan Lokal
- Windows + Laragon, shell PowerShell, bukan WSL
- `APP_ENV=production` di lokal, jadi artisan command yang mengubah DB wajib pakai `--force`
- Akun super_admin: `rio.alvarez@pajak.go.id` (User ID 11)

## Aturan Kerja AI Agent
Sebelum mengubah kode:
1. Jalankan `git status --short` dan jangan revert perubahan yang tidak dibuat sendiri.
2. Cari pola lama dengan `rg` sebelum membuat pola baru.
3. Jika mengubah Filament Resource, Page, atau Widget, baca juga `app/Filament/AGENTS.md`.
4. Jika mengubah Spatie settings, baca juga `app/Settings/AGENTS.md`.
5. Utamakan perubahan kecil dan modular. Jangan pindahkan file lintas modul tanpa alasan kuat.

Saat menambah fitur:
1. Tentukan modul domain dulu: Helpdesk, Inventaris, KendaraanDinas, KnowledgeManagement, ManajemenUser, atau Pengaturan.
2. Ikuti struktur `app/Filament/Modules/<Domain>/...`.
3. Jangan taruh Resource baru di `app/Filament/Resources`.
4. Jangan hardcode permission, module gate, atau navigation gate dengan pola baru sendiri.
5. Jangan membuat UI custom besar di Resource jika bisa dipecah ke class kecil.

## Setelah Tambah/Ubah Filament Resource, Page, atau Widget
Wajib jalankan:
```powershell
php artisan shield:generate --all --panel=admin --no-interaction
php artisan optimize:clear
```

Setelah menjalankan Shield, cek policy karena generator bisa mengembalikan placeholder mentah:
```powershell
rg -n "\{\{ .* \}\}|App\\\\Policies|Illuminate\\\\Auth" app\Policies
```

Jika ada `{{ ForceDelete }}`, `{{ Restore }}`, `{{ Replicate }}`, atau `{{ Reorder }}`, ubah menjadi `return false;` kecuali memang ada aturan bisnis eksplisit.

## Verifikasi Minimum
Untuk perubahan backend/Filament, jalankan ketiganya (sama dengan yang dicek CI):
```powershell
./vendor/bin/pint            # rapikan code style + buang unused import (pakai pint.json)
./vendor/bin/phpstan analyse --memory-limit=1G   # static analysis level 5 (Larastan)
php artisan test
```

Aturan static analysis:
- Jangan menambah entri baru ke `phpstan-baseline.neon` untuk kode baru — perbaiki akar masalahnya. Baseline hanya menampung utang lama.
- Jangan pakai `@phpstan-ignore`, cast, atau `@var` hanya untuk membungkam error.
- CI (`.github/workflows/ci.yml`) menjalankan pint --test + phpstan + test pada setiap push/PR. Pastikan hijau sebelum merge.

Untuk perubahan Blade, CSS, Vite, atau UI:
```powershell
npm run build
```

Untuk migration lokal:
```powershell
php artisan migrate --force
```

## Konvensi Navigasi
Nama group resmi, jangan asal ubah karena banyak Resource mengacu ke string ini:
- `IT Helpdesk`
- `Kendaraan Dinas`
- `Inventaris`
- `Knowledge Management`
- `Manajemen User`
- `Pengaturan`

Setiap Resource/Page yang tampil di sidebar harus memakai key registry:
```php
use App\Filament\Concerns\HasModuleNavigationGate;

use HasModuleNavigationGate;

protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::INVENTORY_DEVICES;
```

Mapping `ModuleSettings` + `NavigationSettings` ada di `app/Filament/Support/ModuleNavigationRegistry.php`.
Jangan menulis ulang pasangan string `enable_*` dan `show_*` di Resource/Page baru.
Jangan menulis ulang `shouldRegisterNavigation()` kecuali perlu gabungan khusus, misalnya Shield page permission atau super_admin-only page. Jika override diperlukan, tetap panggil `passesModuleNavigationGate()`.

## Pola Resource Modular
Resource utama harus tipis. Isi form, table, dan infolist dipindah ke class modular.

Struktur standar:
```text
app/Filament/Modules/<Domain>/Resources/<Name>Resource.php
app/Filament/Modules/<Domain>/Resources/<Name>Resource/Pages/
app/Filament/Modules/<Domain>/Resources/<Name>Resource/Schemas/<Name>Form.php
app/Filament/Modules/<Domain>/Resources/<Name>Resource/Tables/<Name>Table.php
app/Filament/Modules/<Domain>/Resources/<Name>Resource/Infolists/<Name>Infolist.php
```

Jika table mulai besar, pecah lagi:
```text
<Name>Resource/Tables/Concerns/<Name>Columns.php
<Name>Resource/Tables/Concerns/<Name>Filters.php
<Name>Resource/Tables/Concerns/<Name>Actions.php
```

Template Resource tipis:
```php
class DeviceResource extends Resource implements HasShieldPermissions
{
    use HasModuleNavigationGate;

    protected static ?string $model = Device::class;
    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::INVENTORY_DEVICES;

    public static function form(Form $form): Form
    {
        return DeviceForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return DeviceTable::configure($table);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return DeviceInfolist::configure($infolist);
    }
}
```

## Policy dan Permission
Setiap policy harus memakai super admin bypass:
```php
use App\Policies\Concerns\HasSuperAdminBypass;
use App\Policies\Concerns\ChecksPolicyPermissions;

use HandlesAuthorization;
use HasSuperAdminBypass;
use ChecksPolicyPermissions;
```

Aturan:
- Permission standar mengikuti Shield, contoh `view_any_device`, `create_device`, `update_device`.
- Cek permission melalui `$this->canPerform($user, 'permission_name')`, bukan langsung `$user->can(...)`.
- Ability yang belum dipakai seperti `forceDelete`, `restore`, `replicate`, `reorder` default ke `return false;`.
- Jangan biarkan placeholder `{{ ... }}` masuk commit.
- Jangan menaruh aturan role rumit di Blade. Taruh di policy, model method, atau action visibility yang jelas.

## Query dan Eager Loading
Untuk Resource yang menampilkan relasi di table/infolist, tambahkan eager loading di `getEloquentQuery()`:
```php
public static function getEloquentQuery(): Builder
{
    return parent::getEloquentQuery()
        ->with(['user', 'unit']);
}
```

Aturan:
- Jika table menampilkan `user.name`, eager load `user`.
- Jika table menampilkan count, pakai `withCount()` jika memungkinkan.
- Hindari load semua data lalu filter dengan collection untuk report besar.
- Sorting/filtering tabel harus bekerja di query database, bukan hanya data halaman pagination yang sedang tampil.

## Komponen UI Reusable
Jika UI kecil dipakai lebih dari sekali, buat komponen Blade di:
```text
resources/views/filament/components/
```

Contoh yang sudah ada:
- `filament.components.copy-icon-button`

Aturan:
- Jangan duplikasi Alpine/Blade logic copy, badge, empty state, atau action kecil.
- Untuk halaman custom, pakai Tailwind dengan prinsip desain di bawah.
- Untuk Resource standar, pakai API Filament dulu sebelum custom Blade.

## Bahasa UI
Campuran Indonesia + istilah teknis Inggris.
- Gunakan `User`, bukan `Pengguna`, untuk label menu/form/kolom.
- Kata `penggunaan` sebagai usage tetap boleh.

## Database
- Migration tabel: `database/migrations/`
- Migration settings Spatie: `database/settings/`
- Workflow settings detail: `app/Settings/AGENTS.md`

## Prinsip Desain UI
Wajib diterapkan untuk perubahan UI Blade, custom Filament page, dan halaman publik.

Hierarchy:
- Hierarki bukan hanya ukuran. Pakai kombinasi weight, warna, lalu size.
- Label sekunder pakai weight lebih ringan dan warna lebih muda.

Spacing dan layout:
- Pakai skala Tailwind konsisten: `2`, `3`, `4`, `6`, `8`, `12`, `16`.
- Whitespace lebih baik daripada terlalu banyak border.
- Elemen terkait didekatkan; elemen tidak terkait diberi jarak lebih besar.

Warna:
- Bangun dari palet 50 sampai 900.
- Jangan pakai pure black `#000`.
- Warna untuk emphasis, bukan dekorasi.
- Satu warna aksi utama per layar.

Tipografi:
- Maksimal 2 sampai 3 font weight.
- Ukuran font ikut skala Tailwind.
- Long text pakai line-height longgar, heading pakai line-height rapat.

Depth dan state:
- Shadow halus saja: `shadow-sm` atau `shadow`.
- Semua elemen interaktif wajib punya hover, active, focus, dan disabled state jika relevan.
- Empty, loading, dan error state harus eksplisit.

Form:
- Label di atas input untuk form panjang/mobile.
- Helper text di bawah input dengan `text-sm text-gray-500`.
- Tombol primer satu per layar atau section.

Reduksi visual noise:
- Mulai dari grayscale, tambah warna terakhir.
- Border, icon, atau badge yang tidak menambah informasi sebaiknya dihapus.
