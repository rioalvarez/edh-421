# Filament Agent Guide

Dokumen ini wajib dibaca sebelum agent mengubah Filament Resource, Page, Widget, atau Blade admin.

## Struktur Modul
Semua Filament domain berada di:
```text
app/Filament/Modules/
```

Domain yang ada:
- `Helpdesk`
- `Inventaris`
- `KendaraanDinas`
- `KnowledgeManagement`
- `ManajemenUser`
- `Pengaturan`

Jangan membuat Resource baru di `app/Filament/Resources`. Folder lama sudah tidak menjadi pola utama.

## Resource Baru
Checklist:
1. Buat Resource di `app/Filament/Modules/<Domain>/Resources`.
2. Implement `HasShieldPermissions`.
3. Pakai `HasModuleNavigationGate`.
4. Isi `$moduleNavigationKey` dari `ModuleNavigationRegistry`.
5. Pecah form/table/infolist ke class modular.
6. Tambahkan eager loading untuk relasi yang tampil di table.
7. Jalankan Shield dan cache clear.

Template minimal:
```php
use App\Filament\Concerns\HasModuleNavigationGate;
use BezhanSalleh\FilamentShield\Contracts\HasShieldPermissions;

class ExampleResource extends Resource implements HasShieldPermissions
{
    use HasModuleNavigationGate;

    protected static ?string $model = Example::class;
    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::INVENTORY_DEVICES;

    public static function form(Form $form): Form
    {
        return ExampleForm::configure($form);
    }

    public static function table(Table $table): Table
    {
        return ExampleTable::configure($table);
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return ExampleInfolist::configure($infolist);
    }
}
```

## Form, Table, Infolist
Pola file:
```text
ExampleResource/Schemas/ExampleForm.php
ExampleResource/Tables/ExampleTable.php
ExampleResource/Infolists/ExampleInfolist.php
```

Jika table lebih dari sekitar 180 baris, pecah:
```text
ExampleResource/Tables/Concerns/ExampleColumns.php
ExampleResource/Tables/Concerns/ExampleFilters.php
ExampleResource/Tables/Concerns/ExampleActions.php
```

`ExampleTable` hanya boleh merangkai:
```php
return $table
    ->columns(ExampleColumns::make())
    ->filters(ExampleFilters::make())
    ->actions(ExampleActions::rowActions())
    ->bulkActions(ExampleActions::bulkActions());
```

## Gate Navigation
Pola default:
```php
use HasModuleNavigationGate;

protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::HELPDESK_TICKETS;
```

Tambah/mapping gate baru di `app/Filament/Support/ModuleNavigationRegistry.php`.
Jangan menulis ulang pasangan setting `enable_*` dan `show_*` di Resource/Page.

Untuk Page yang juga memakai `HasPageShield`, gabungkan secara eksplisit:
```php
use HasModuleNavigationGate, HasPageShield {
    HasModuleNavigationGate::shouldRegisterNavigation insteadof HasPageShield;
    HasPageShield::shouldRegisterNavigation as protected shouldRegisterByShield;
}

public static function shouldRegisterNavigation(): bool
{
    return static::passesModuleNavigationGate()
        && static::shouldRegisterByShield();
}
```

## Query Resource
Tambahkan relasi yang dipakai di table/infolist:
```php
public static function getEloquentQuery(): Builder
{
    return parent::getEloquentQuery()
        ->with(['user', 'assignedTo', 'device']);
}
```

Untuk statistik, badge, atau jumlah data, utamakan query aggregate:
```php
->withCount('tickets')
```

Jangan sorting/filtering data dengan collection setelah pagination.

## Policy Setelah Shield
Setelah menjalankan:
```powershell
php artisan shield:generate --all --panel=admin --no-interaction
```

Selalu cek:
```powershell
rg -n "\{\{ .* \}\}|App\\\\Policies|Illuminate\\\\Auth" app\Policies
```

Policy harus:
- memakai `HasSuperAdminBypass`
- tidak punya placeholder `{{ ... }}`
- default `forceDelete`, `restore`, `replicate`, `reorder` ke `return false;` jika belum ada aturan bisnis

## Widget
Widget harus mengikuti gate modul yang sama dengan Resource/Page.
Pakai `HasModuleWidgetGate` dan `$moduleNavigationKey`, lalu panggil `static::passesModuleWidgetGate()` di `canView()`.

Contoh:
```php
use HasModuleWidgetGate;

protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::HELPDESK_TICKETS;

public static function canView(): bool
{
    return static::passesModuleWidgetGate()
        && auth()->user()?->isItAdmin();
}
```

## UI Admin
Gunakan komponen reusable jika UI dipakai ulang:
```text
resources/views/filament/components/
```

Jangan membuat inline Alpine/Blade copy button baru jika bisa pakai:
```blade
@include('filament.components.copy-icon-button', [
    'value' => $value,
    'label' => 'Salin',
    'message' => 'Disalin',
])
```

Untuk tombol, pakai icon Heroicon/Lucide/Filament jika tersedia. Jangan buat SVG manual kecuali tidak ada alternatif.

### Tombol di Blade custom
Untuk **tombol aksi generik di Blade** (mis. tombol submit di widget/custom view), pakai komponen reusable `<x-ui.button>` — jangan tulis `<button class="px-4 py-2 bg-... ">` mentah.

```blade
<x-ui.button type="submit" variant="primary" icon-after="heroicon-o-paper-airplane">
    Kirim
</x-ui.button>

{{-- ikon saja --}}
<x-ui.button variant="danger" icon="heroicon-o-trash" wire:click="delete" />

{{-- sebagai link --}}
<x-ui.button :href="route('...')" variant="secondary">Kembali</x-ui.button>
```

Props: `variant` (primary|secondary|danger|success|warning|ghost), `size` (sm|md|lg), `icon`, `icon-after`, `href`. Atribut lain (`type`, `wire:click`, `x-on:click`, `class`) diteruskan otomatis.

Catatan: komponen ada di `resources/views/components/ui/button.blade.php`. Variant warna memakai token Filament (`primary`/`danger`/dst) sehingga seragam di **panel**. Untuk **halaman publik** (`app.css`), hanya variant `secondary`/`ghost` (abu-abu) yang aman kecuali palet warna ditambahkan ke `tailwind.config.js` root.

**Catatan:** Filament Action (CreateAction/EditAction/Action::make) sudah punya sistem tombol sendiri — biarkan, jangan ganti dengan `<x-ui.button>`. Komponen ini hanya untuk `<button>`/anchor mentah di Blade.

## Command Wajib
Setelah mengubah Filament Resource, Page, atau Widget:
```powershell
php artisan shield:generate --all --panel=admin --no-interaction
php artisan optimize:clear
Get-ChildItem app -Recurse -Filter *.php | ForEach-Object { php -l $_.FullName }
php artisan test
```

Jika menyentuh Blade/CSS/Vite:
```powershell
npm run build
```
