# Paku-IT

Aplikasi IT internal: Helpdesk, Inventaris IT, KDO, dan Knowledge Management.

> **Sumber utama panduan ada di `AGENTS.md`.** Ikuti file itu (dan `app/Filament/AGENTS.md`, `app/Settings/AGENTS.md`) sebelum mengubah kode. File ini hanya ringkasan agar tidak ada dua sumber yang saling bertentangan.

## Stack
- Laravel 12, Filament 3, MySQL (Laragon)
- Spatie: laravel-permission, laravel-settings; BezhanSalleh FilamentShield
- Auth: Filament Breezy + Socialite Google SSO

## Lingkungan Lokal
- Windows + Laragon, shell PowerShell, bukan WSL
- `APP_ENV=production` di lokal → artisan yang mengubah DB wajib `--force`
- Akun super_admin: `rio.alvarez@pajak.go.id` (User ID 11)

## Arsitektur (ringkas — detail di AGENTS.md)
- Domain Filament ada di `app/Filament/Modules/<Domain>/` (Helpdesk, Inventaris, KendaraanDinas, KnowledgeManagement, ManajemenUser, Pengaturan). **Jangan** buat Resource baru di `app/Filament/Resources`.
- Resource **tipis**: form/table/infolist didelegasikan ke `Schemas/`, `Tables/`, `Infolists/`.
- Navigasi sidebar pakai `HasModuleNavigationGate` + `$moduleNavigationKey` dari `App\Filament\Support\ModuleNavigationRegistry`. Jangan tulis ulang cek `ModuleSettings`/`NavigationSettings` manual.
- Widget pakai `HasModuleWidgetGate`.
- Policy pakai `HasSuperAdminBypass` + `ChecksPolicyPermissions`.
- Status/type/priority/condition pakai **enum** di `app/Enums/` (label/color/options), bukan `match()` hardcode.
- Tombol aksi generik di Blade custom pakai komponen **`<x-ui.button>`** (`resources/views/components/ui/button.blade.php`), bukan `<button>` mentah. Filament Action tidak diubah.
- Settings (Spatie) → workflow di `app/Settings/AGENTS.md`.

## Setelah Tambah/Ubah Resource, Page, atau Widget
```
php artisan shield:generate --all --panel=admin
php artisan optimize:clear
```
Jika menyentuh Blade/CSS/Vite: `npm run build`.

## Bahasa UI
Campuran Indonesia + istilah teknis Inggris. Gunakan **"User"** (bukan "Pengguna") untuk label menu/form/kolom. Kata "penggunaan" (usage) berbeda — biarkan.

## Prinsip Desain UI (Refactoring UI — Adam Wathan)
Wajib untuk setiap perubahan UI (Blade view, custom Filament page, halaman publik).

**Hierarchy** — Pakai kombinasi weight + warna (gray-900 vs gray-500), baru size. Label sekunder pakai weight lebih ringan + warna lebih muda.

**Spacing & Layout** — Skala spasi konsisten (2, 3, 4, 6, 8, 12, 16). Whitespace > border. Elemen terkait didekatkan, yang tidak dijauhkan.

**Warna** — Bangun dari palet 50–900 (`primary => Amber`). Hindari pure black/gray. Warna untuk emphasis, satu aksi utama per layar.

**Tipografi** — Maks 2–3 weight. Ukuran ikut skala Tailwind. Line-height longgar untuk teks panjang, rapat untuk heading.

**Depth & State** — Shadow halus (`shadow-sm`). Hover/active/focus/disabled wajib ada. Empty/loading/error state eksplisit.

**Form** — Label di atas input untuk form panjang. Helper text `text-sm text-gray-500`. Satu tombol primer per section.

**Reduksi Noise** — Mulai grayscale, tambah warna terakhir. Kalau ragu, hapus.
