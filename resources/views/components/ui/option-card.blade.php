@props([
    'selected' => false,
])

<button
    type="button"
    {{ $attributes->class([
        'group rounded-lg border p-3 text-left transition hover:border-primary-300 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-primary-500 disabled:opacity-60 disabled:pointer-events-none dark:hover:bg-white/5',
        'border-primary-500 bg-primary-50/60 ring-1 ring-primary-500 dark:bg-primary-500/10' => $selected,
        'border-gray-200 dark:border-white/10' => ! $selected,
    ]) }}
>
    {{ $slot }}
</button>
