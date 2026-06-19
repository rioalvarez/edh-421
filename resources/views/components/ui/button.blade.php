@props([
    'variant' => 'primary',   // primary | secondary | danger | success | warning | ghost
    'size' => 'md',           // sm | md | lg
    'icon' => null,           // nama komponen heroicon, mis. 'heroicon-o-paper-airplane' (di depan label)
    'iconAfter' => null,      // ikon di belakang label
    'href' => null,           // jika diisi -> render <a>, selain itu <button>
])

@php
    $base = 'inline-flex items-center justify-center font-medium rounded-lg shadow-sm transition-colors '
        . 'focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 '
        . 'disabled:opacity-60 disabled:pointer-events-none dark:focus-visible:ring-offset-gray-900';

    $variants = [
        'primary'   => 'bg-primary-600 text-white hover:bg-primary-500 focus-visible:ring-primary-600',
        'secondary' => 'bg-white text-gray-700 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-gray-400 dark:bg-white/5 dark:text-gray-200 dark:ring-gray-700 dark:hover:bg-white/10',
        'danger'    => 'bg-danger-600 text-white hover:bg-danger-500 focus-visible:ring-danger-600',
        'success'   => 'bg-success-600 text-white hover:bg-success-500 focus-visible:ring-success-600',
        'warning'   => 'bg-warning-500 text-white hover:bg-warning-600 focus-visible:ring-warning-500',
        'ghost'     => 'bg-transparent text-gray-700 hover:bg-gray-100 focus-visible:ring-gray-400 dark:text-gray-200 dark:hover:bg-white/5',
    ];

    $sizes = [
        'sm' => 'gap-1.5 px-3 py-1.5 text-xs',
        'md' => 'gap-2 px-4 py-2 text-sm',
        'lg' => 'gap-2 px-5 py-2.5 text-base',
    ];

    $iconSize = $size === 'sm' ? 'h-4 w-4' : 'h-5 w-5';

    $classes = trim($base . ' ' . ($variants[$variant] ?? $variants['primary']) . ' ' . ($sizes[$size] ?? $sizes['md']));
@endphp

@if ($href)
    <a href="{{ $href }}" {{ $attributes->merge(['class' => $classes]) }}>
        @if ($icon)
            <x-dynamic-component :component="$icon" class="{{ $iconSize }}" />
        @endif
        {{ $slot }}
        @if ($iconAfter)
            <x-dynamic-component :component="$iconAfter" class="{{ $iconSize }}" />
        @endif
    </a>
@else
    <button {{ $attributes->merge(['type' => 'button', 'class' => $classes]) }}>
        @if ($icon)
            <x-dynamic-component :component="$icon" class="{{ $iconSize }}" />
        @endif
        {{ $slot }}
        @if ($iconAfter)
            <x-dynamic-component :component="$iconAfter" class="{{ $iconSize }}" />
        @endif
    </button>
@endif
