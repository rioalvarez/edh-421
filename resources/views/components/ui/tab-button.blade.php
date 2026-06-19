@props([
    'icon' => null,
])

<button
    type="button"
    {{ $attributes->merge([
        'class' => 'flex items-center gap-2 -mb-px border-b-2 px-4 py-2.5 text-sm font-medium transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-primary-500 focus-visible:ring-offset-2 dark:focus-visible:ring-offset-gray-900',
    ]) }}
>
    @if ($icon)
        <x-dynamic-component :component="$icon" class="h-5 w-5" />
    @endif

    {{ $slot }}
</button>
