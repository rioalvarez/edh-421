<x-filament-widgets::widget>
    <x-filament::section>
        <x-slot name="heading">
            Kalender Ketersediaan Kendaraan
        </x-slot>

        <div class="space-y-4">
            {{-- Vehicle Selector --}}
            <div class="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
                <div class="w-full sm:w-64">
                    <select
                        wire:model.live="selectedVehicleId"
                        class="w-full rounded-lg border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-white shadow-sm focus:border-primary-500 focus:ring-primary-500"
                    >
                        <option value="">-- Pilih Kendaraan --</option>
                        @foreach($this->getVehicles() as $id => $name)
                            <option value="{{ $id }}">{{ $name }}</option>
                        @endforeach
                    </select>
                </div>

                {{-- Month Navigation --}}
                <div class="flex items-center gap-2">
                    <x-filament::button
                        wire:click="previousMonth"
                        icon="heroicon-m-chevron-left"
                        size="sm"
                        color="gray"
                    />
                    <span class="text-lg font-semibold min-w-[150px] text-center dark:text-white">
                        {{ $this->getCurrentMonthLabel() }}
                    </span>
                    <x-filament::button
                        wire:click="nextMonth"
                        icon="heroicon-m-chevron-right"
                        size="sm"
                        color="gray"
                    />
                </div>
            </div>

            {{-- Legend --}}
            <div class="flex flex-wrap gap-4 text-sm">
                <div class="flex items-center gap-2">
                    <div class="w-4 h-4 rounded" style="background-color: rgb(34 197 94);"></div>
                    <span class="dark:text-gray-300">Tersedia</span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="w-4 h-4 rounded" style="background-color: rgb(239 68 68);"></div>
                    <span class="dark:text-gray-300">Sudah Dibooking</span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="w-4 h-4 rounded" style="background-color: rgb(245 158 11);"></div>
                    <span class="dark:text-gray-300">Hari Ini</span>
                </div>
            </div>

            @if($this->selectedVehicleId)
                {{-- Calendar Grid --}}
                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <thead>
                            <tr>
                                @foreach(['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'] as $day)
                                    <th class="p-2 text-center text-sm font-medium text-gray-600 dark:text-gray-400 border border-gray-200 dark:border-gray-700">
                                        {{ $day }}
                                    </th>
                                @endforeach
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($this->getCalendarData() as $week)
                                <tr>
                                    @foreach($week as $day)
                                        <td
                                            class="p-1 border border-gray-200 dark:border-gray-700 align-top h-20 sm:h-24
                                                {{ !$day['isCurrentMonth'] ? 'bg-gray-50 dark:bg-gray-800/50' : '' }}
                                                {{ $day['isPast'] ? 'opacity-50' : '' }}"
                                        >
                                            <div class="h-full flex flex-col">
                                                {{-- Date Number --}}
                                                <div class="flex justify-between items-start mb-1">
                                                    <span class="inline-flex items-center justify-center w-7 h-7 text-sm rounded-full
                                                        {{ $day['isToday'] ? 'bg-primary-500 text-white font-bold' : '' }}
                                                        {{ !$day['isCurrentMonth'] ? 'text-gray-400 dark:text-gray-600' : 'text-gray-700 dark:text-gray-300' }}
                                                    ">
                                                        {{ $day['day'] }}
                                                    </span>

                                                    @if($day['isCurrentMonth'] && !$day['isPast'])
                                                        @if($day['isBooked'])
                                                            <span class="inline-flex items-center justify-center w-5 h-5 rounded-full" style="background-color: rgb(239 68 68);">
                                                                <x-heroicon-m-x-mark class="w-3 h-3 text-white" />
                                                            </span>
                                                        @else
                                                            <span class="inline-flex items-center justify-center w-5 h-5 rounded-full" style="background-color: rgb(34 197 94);">
                                                                <x-heroicon-m-check class="w-3 h-3 text-white" />
                                                            </span>
                                                        @endif
                                                    @endif
                                                </div>

                                                {{-- Booking Info --}}
                                                @if($day['isBooked'] && $day['isCurrentMonth'])
                                                    <div class="flex-1 overflow-hidden">
                                                        @foreach(array_slice($day['bookings'], 0, 2) as $booking)
                                                            <div
                                                                class="text-xs p-1 mb-1 rounded truncate"
                                                                style="background-color: {{ $booking['status'] === 'in_use' ? 'rgba(234, 179, 8, 0.2)' : 'rgba(239, 68, 68, 0.2)' }}; color: {{ $booking['status'] === 'in_use' ? 'rgb(161 98 7)' : 'rgb(185 28 28)' }};"
                                                                title="{{ $booking['user'] }} - {{ $booking['destination'] }}"
                                                            >
                                                                {{ $booking['user'] }}
                                                            </div>
                                                        @endforeach
                                                        @if(count($day['bookings']) > 2)
                                                            <div class="text-xs text-gray-500 dark:text-gray-400">
                                                                +{{ count($day['bookings']) - 2 }} lagi
                                                            </div>
                                                        @endif
                                                    </div>
                                                @endif
                                            </div>
                                        </td>
                                    @endforeach
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            @else
                <div class="text-center py-8 text-gray-500 dark:text-gray-400">
                    <x-heroicon-o-truck class="w-12 h-12 mx-auto mb-2 opacity-50" />
                    <p>Pilih kendaraan untuk melihat kalender ketersediaan</p>
                </div>
            @endif
        </div>
    </x-filament::section>
</x-filament-widgets::widget>
