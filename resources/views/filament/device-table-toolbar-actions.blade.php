<x-filament::button
    size="sm"
    color="gray"
    icon="heroicon-o-arrow-down-tray"
    wire:click="mountTableHeaderAction('export')"
>
    Ekspor
</x-filament::button>

<x-filament::button
    size="sm"
    color="gray"
    icon="heroicon-o-arrow-up-tray"
    wire:click="mountTableHeaderAction('import')"
>
    Impor
</x-filament::button>
