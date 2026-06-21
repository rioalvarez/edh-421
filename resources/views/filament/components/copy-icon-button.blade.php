@props([
    'value',
    'label' => 'Salin',
    'message' => 'Disalin',
])

@if (filled($value))
    <button
        type="button"
        x-data="{ copied: false, value: @js($value) }"
        x-on:click.stop.prevent="
            const copyText = (text) => {
                if (navigator.clipboard && window.isSecureContext) {
                    return navigator.clipboard.writeText(text);
                }
                const textarea = document.createElement('textarea');
                textarea.value = text;
                textarea.style.position = 'fixed';
                textarea.style.opacity = '0';
                document.body.appendChild(textarea);
                textarea.select();
                document.execCommand('copy');
                document.body.removeChild(textarea);
                return Promise.resolve();
            };
            copyText(value).then(() => {
                copied = true;
                setTimeout(() => copied = false, 1500);
            });
        "
        x-bind:title="copied ? @js($message) : @js($label)"
        {{ $attributes->class([
            'inline-flex h-6 w-6 items-center justify-center rounded-md text-gray-400 transition',
            'hover:bg-gray-100 hover:text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-1',
            'dark:hover:bg-gray-800 dark:hover:text-gray-200',
        ]) }}
        aria-label="{{ $label }}"
    >
        <template x-if="!copied">
            <x-heroicon-o-clipboard-document class="h-4 w-4" />
        </template>
        <template x-if="copied">
            <x-heroicon-o-clipboard-document-check class="h-4 w-4 text-success-500" />
        </template>
    </button>
@endif
