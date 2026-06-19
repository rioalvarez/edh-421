<x-filament-panels::page>
    <div x-data="{ tab: 'statistik' }" class="space-y-6">
        {{-- Tab navigation --}}
        <div class="flex items-center gap-1 border-b border-gray-200 dark:border-gray-700">
            <x-ui.tab-button
                x-on:click="tab = 'statistik'"
                x-bind:class="tab === 'statistik'
                    ? 'border-primary-500 text-primary-600 dark:text-primary-400'
                    : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
                icon="heroicon-o-chart-bar-square"
            >
                Statistik Perangkat
            </x-ui.tab-button>

            <x-ui.tab-button
                x-on:click="tab = 'daftar'"
                x-bind:class="tab === 'daftar'
                    ? 'border-primary-500 text-primary-600 dark:text-primary-400'
                    : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
                icon="heroicon-o-list-bullet"
            >
                Daftar Perangkat
            </x-ui.tab-button>
        </div>

        {{-- Tab: Statistik Perangkat --}}
        <div x-show="tab === 'statistik'">
            @livewire(\App\Filament\Widgets\DeviceStatsWidget::class)
        </div>

        {{-- Tab: Daftar Perangkat --}}
        <div x-show="tab === 'daftar'" x-cloak>
            {{ $this->table }}
        </div>
    </div>
</x-filament-panels::page>
