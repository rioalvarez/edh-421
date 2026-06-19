<?php

namespace App\Filament\Pages;

use Filament\Notifications\Notification;
use Filament\Pages\Page;

class ThemeColorPage extends Page
{
    protected static string $view = 'filament.pages.theme-color';

    protected static ?string $title = 'Tampilan Admin';

    protected static ?string $navigationIcon = 'heroicon-o-swatch';

    protected static ?string $slug = 'theme-color';

    protected static bool $shouldRegisterNavigation = false;

    public string $selectedColor = 'amber';

    public string $selectedGray = 'slate';

    public int $selectedLevel = 1;

    public string $selectedSidebarStyle = 'default';

    public string $selectedNavbarStyle = 'clean';

    public string $selectedDensity = 'comfortable';

    public string $selectedRadius = 'default';

    public string $selectedContentWidth = 'normal';

    public function mount(): void
    {
        $user = auth()->user();
        $this->selectedColor = $user->theme_color ?? 'amber';
        $this->selectedGray = $user->theme_gray ?? 'slate';
        $this->selectedLevel = (int) ($user->theme_gray_level ?? 1);
        $this->selectedSidebarStyle = $user->theme_sidebar_style ?? 'default';
        $this->selectedNavbarStyle = $user->theme_navbar_style ?? 'clean';
        $this->selectedDensity = $user->theme_density ?? 'comfortable';
        $this->selectedRadius = $user->theme_radius ?? 'default';
        $this->selectedContentWidth = $user->theme_content_width ?? 'normal';
    }

    public function selectColor(string $color): void
    {
        if (! array_key_exists($color, static::getPrimaryColors())) {
            return;
        }

        $this->selectedColor = $color;
        $this->updateThemePreference(['theme_color' => $color], 'Warna aksen diperbarui');
    }

    public function selectGray(string $gray): void
    {
        if (! array_key_exists($gray, static::getGrayTones())) {
            return;
        }

        $this->selectedGray = $gray;
        $this->updateThemePreference(['theme_gray' => $gray], 'Tone dasar diperbarui');
    }

    public function selectLevel(int $level): void
    {
        if (! array_key_exists($level, static::getIntensityLevels())) {
            return;
        }

        $this->selectedLevel = $level;
        $this->updateThemePreference(['theme_gray_level' => $level], 'Intensitas diperbarui');
    }

    public function selectSidebarStyle(string $style): void
    {
        if (! array_key_exists($style, static::getSidebarStyles())) {
            return;
        }

        $this->selectedSidebarStyle = $style;
        $this->updateThemePreference(['theme_sidebar_style' => $style], 'Sidebar diperbarui');
    }

    public function selectNavbarStyle(string $style): void
    {
        if (! array_key_exists($style, static::getNavbarStyles())) {
            return;
        }

        $this->selectedNavbarStyle = $style;
        $this->updateThemePreference(['theme_navbar_style' => $style], 'Navbar diperbarui');
    }

    public function selectDensity(string $density): void
    {
        if (! array_key_exists($density, static::getDensityOptions())) {
            return;
        }

        $this->selectedDensity = $density;
        $this->updateThemePreference(['theme_density' => $density], 'Kerapatan UI diperbarui');
    }

    public function selectRadius(string $radius): void
    {
        if (! array_key_exists($radius, static::getRadiusOptions())) {
            return;
        }

        $this->selectedRadius = $radius;
        $this->updateThemePreference(['theme_radius' => $radius], 'Radius UI diperbarui');
    }

    public function selectContentWidth(string $width): void
    {
        if (! array_key_exists($width, static::getContentWidthOptions())) {
            return;
        }

        $this->selectedContentWidth = $width;
        $this->updateThemePreference(['theme_content_width' => $width], 'Lebar konten diperbarui');
    }

    private function updateThemePreference(array $data, string $message): void
    {
        auth()->user()->update($data);
        Notification::make()->title($message)->success()->send();
        $this->redirect(static::getUrl());
    }

    public static function getPrimaryColors(): array
    {
        return [
            'amber' => ['label' => 'Amber',  'hex' => '#f59e0b'],
            'blue' => ['label' => 'Biru',   'hex' => '#3b82f6'],
            'indigo' => ['label' => 'Indigo', 'hex' => '#6366f1'],
            'green' => ['label' => 'Hijau',  'hex' => '#22c55e'],
            'red' => ['label' => 'Merah',  'hex' => '#ef4444'],
            'violet' => ['label' => 'Violet', 'hex' => '#8b5cf6'],
            'orange' => ['label' => 'Oranye', 'hex' => '#f97316'],
            'teal' => ['label' => 'Teal',   'hex' => '#14b8a6'],
            'pink' => ['label' => 'Pink',   'hex' => '#ec4899'],
            'rose' => ['label' => 'Rose',   'hex' => '#f43f5e'],
            'cyan' => ['label' => 'Cyan',   'hex' => '#06b6d4'],
        ];
    }

    public static function getGrayTones(): array
    {
        // shades[0..3] = preview untuk level 1-4 (Terang → Tajam)
        return [
            'slate' => ['label' => 'Slate',   'hex' => '#64748b', 'shades' => ['#cbd5e1', '#64748b', '#334155', '#0f172a']],
            'blue' => ['label' => 'Biru',    'hex' => '#3b82f6', 'shades' => ['#93c5fd', '#3b82f6', '#1d4ed8', '#1e3a8a']],
            'indigo' => ['label' => 'Indigo',  'hex' => '#6366f1', 'shades' => ['#a5b4fc', '#6366f1', '#4338ca', '#312e81']],
            'violet' => ['label' => 'Violet',  'hex' => '#8b5cf6', 'shades' => ['#c4b5fd', '#8b5cf6', '#6d28d9', '#4c1d95']],
            'emerald' => ['label' => 'Hijau',   'hex' => '#10b981', 'shades' => ['#6ee7b7', '#10b981', '#047857', '#064e3b']],
            'teal' => ['label' => 'Teal',    'hex' => '#14b8a6', 'shades' => ['#5eead4', '#14b8a6', '#0f766e', '#134e4a']],
            'rose' => ['label' => 'Rose',    'hex' => '#f43f5e', 'shades' => ['#fda4af', '#f43f5e', '#be123c', '#881337']],
            'amber' => ['label' => 'Amber',   'hex' => '#f59e0b', 'shades' => ['#fcd34d', '#f59e0b', '#b45309', '#78350f']],
            'orange' => ['label' => 'Oranye',  'hex' => '#f97316', 'shades' => ['#fdba74', '#f97316', '#c2410c', '#7c2d12']],
            'pink' => ['label' => 'Pink',    'hex' => '#ec4899', 'shades' => ['#f9a8d4', '#ec4899', '#be185d', '#831843']],
        ];
    }

    public static function getIntensityLevels(): array
    {
        return [
            1 => 'Terang',
            2 => 'Normal',
            3 => 'Gelap',
            4 => 'Tajam',
        ];
    }

    public static function getSidebarStyles(): array
    {
        return [
            'default' => [
                'label' => 'Default',
                'description' => 'Sidebar standar Filament.',
                'preview' => 'bg-white ring-gray-200',
            ],
            'soft' => [
                'label' => 'Soft',
                'description' => 'Permukaan sidebar lebih halus.',
                'preview' => 'bg-gray-50 ring-gray-200',
            ],
            'dark' => [
                'label' => 'Dark',
                'description' => 'Sidebar gelap untuk fokus navigasi.',
                'preview' => 'bg-gray-900 ring-gray-800',
            ],
            'contrast' => [
                'label' => 'Kontras',
                'description' => 'Sidebar lebih tegas untuk layar terang.',
                'preview' => 'bg-gray-100 ring-gray-300',
            ],
        ];
    }

    public static function getNavbarStyles(): array
    {
        return [
            'clean' => [
                'label' => 'Clean',
                'description' => 'Navbar polos dan ringan.',
            ],
            'elevated' => [
                'label' => 'Elevated',
                'description' => 'Navbar dengan shadow halus.',
            ],
            'bordered' => [
                'label' => 'Bordered',
                'description' => 'Navbar memakai garis pemisah.',
            ],
            'glass' => [
                'label' => 'Glass',
                'description' => 'Navbar translucent dengan blur ringan.',
            ],
        ];
    }

    public static function getDensityOptions(): array
    {
        return [
            'comfortable' => [
                'label' => 'Nyaman',
                'description' => 'Jarak standar untuk penggunaan umum.',
            ],
            'compact' => [
                'label' => 'Padat',
                'description' => 'Lebih banyak data terlihat di layar.',
            ],
            'dense' => [
                'label' => 'Sangat Padat',
                'description' => 'Untuk admin yang sering scan tabel besar.',
            ],
        ];
    }

    public static function getRadiusOptions(): array
    {
        return [
            'default' => [
                'label' => 'Default',
                'description' => 'Radius standar Filament.',
            ],
            'soft' => [
                'label' => 'Soft',
                'description' => 'Permukaan terasa sedikit lebih ramah.',
            ],
            'sharp' => [
                'label' => 'Sharp',
                'description' => 'Sudut lebih tegas dan utilitarian.',
            ],
        ];
    }

    public static function getContentWidthOptions(): array
    {
        return [
            'normal' => [
                'label' => 'Normal',
                'description' => 'Lebar konten standar.',
            ],
            'wide' => [
                'label' => 'Wide',
                'description' => 'Lebih lega untuk tabel dan form panjang.',
            ],
            'full' => [
                'label' => 'Full',
                'description' => 'Gunakan hampir seluruh lebar layar.',
            ],
        ];
    }
}
