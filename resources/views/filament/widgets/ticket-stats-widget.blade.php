<x-filament-widgets::widget>
    <x-filament::section>
        <x-slot name="heading">
            <div class="flex items-center gap-2">
                <x-heroicon-o-ticket class="w-5 h-5 text-primary-500" />
                Statistik Layanan Tiketing
            </div>
        </x-slot>

        <x-slot name="description">
            Ringkasan status dan performa layanan IT helpdesk
        </x-slot>

        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            @foreach($this->getStats() as $stat)
                @php
                    $color = $stat->getColor() ?? 'gray';
                    $bgColor = match($color) {
                        'danger' => 'bg-danger-50 dark:bg-danger-950',
                        'warning' => 'bg-warning-50 dark:bg-warning-950',
                        'success' => 'bg-success-50 dark:bg-success-950',
                        'info' => 'bg-info-50 dark:bg-info-950',
                        'primary' => 'bg-primary-50 dark:bg-primary-950',
                        default => 'bg-gray-50 dark:bg-gray-800',
                    };
                    $textColor = match($color) {
                        'danger' => 'text-danger-600 dark:text-danger-400',
                        'warning' => 'text-warning-600 dark:text-warning-400',
                        'success' => 'text-success-600 dark:text-success-400',
                        'info' => 'text-info-600 dark:text-info-400',
                        'primary' => 'text-primary-600 dark:text-primary-400',
                        default => 'text-gray-600 dark:text-gray-400',
                    };
                    $iconColor = match($color) {
                        'danger' => 'text-danger-500',
                        'warning' => 'text-warning-500',
                        'success' => 'text-success-500',
                        'info' => 'text-info-500',
                        'primary' => 'text-primary-500',
                        default => 'text-gray-500',
                    };
                @endphp
                <div class="p-4 rounded-xl {{ $bgColor }} border border-gray-200 dark:border-gray-700">
                    {{-- Stat Value --}}
                    <div class="text-2xl font-bold {{ $textColor }}">
                        {{ $stat->getValue() }}
                    </div>

                    {{-- Stat Label --}}
                    <div class="mt-1 text-sm font-medium text-gray-500 dark:text-gray-400">
                        {{ $stat->getLabel() }}
                    </div>

                    {{-- Description --}}
                    @if($stat->getDescription())
                        <div class="mt-2 flex items-center gap-1 text-xs text-gray-500 dark:text-gray-400">
                            @if($stat->getDescriptionIcon())
                                <x-filament::icon
                                    :icon="$stat->getDescriptionIcon()"
                                    class="w-4 h-4 {{ $iconColor }}"
                                />
                            @endif
                            <span>{{ $stat->getDescription() }}</span>
                        </div>
                    @endif
                </div>
            @endforeach
        </div>
    </x-filament::section>
</x-filament-widgets::widget>
