@props([
    'selected' => false,
    'color',
    'label',
])

<button
    type="button"
    title="{{ $label }}"
    style="background-color: {{ $color }}"
    {{ $attributes->class([
        'relative h-8 w-8 rounded-full shadow-sm transition hover:scale-110 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 disabled:opacity-60 disabled:pointer-events-none dark:focus:ring-offset-gray-900',
        'ring-2 ring-gray-500 ring-offset-2 dark:ring-gray-300 dark:ring-offset-gray-900' => $selected,
    ]) }}
>
    @if ($selected)
        <x-heroicon-o-check class="absolute inset-2 h-4 w-4 text-white drop-shadow" />
    @endif
</button>
