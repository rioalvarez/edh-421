<x-filament-panels::page>
    <div class="space-y-6">
        {{-- Header Controls --}}
        <div class="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
            {{-- Month Navigation --}}
            <div class="flex items-center gap-2">
                <x-filament::button
                    wire:click="previousMonth"
                    icon="heroicon-m-chevron-left"
                    size="sm"
                    color="gray"
                />
                <span class="text-xl font-bold min-w-[180px] text-center dark:text-white">
                    {{ $this->getCurrentMonthLabel() }}
                </span>
                <x-filament::button
                    wire:click="nextMonth"
                    icon="heroicon-m-chevron-right"
                    size="sm"
                    color="gray"
                />
                <x-filament::button
                    wire:click="goToToday"
                    size="sm"
                    color="gray"
                    class="ml-2"
                >
                    Hari Ini
                </x-filament::button>
            </div>

            {{-- Legend --}}
            <div class="flex flex-wrap gap-4 text-sm">
                <div class="flex items-center gap-2">
                    <div class="w-4 h-4 rounded" style="background-color: rgb(34 197 94);"></div>
                    <span class="dark:text-gray-300">Tersedia</span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="w-4 h-4 rounded" style="background-color: rgb(234 179 8);"></div>
                    <span class="dark:text-gray-300">Sedang Digunakan</span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="w-4 h-4 rounded" style="background-color: rgb(239 68 68);"></div>
                    <span class="dark:text-gray-300">Sudah Dibooking</span>
                </div>
            </div>
        </div>

        {{-- Calendar Table --}}
        <x-filament::section>
            <div class="overflow-x-auto">
                <table class="w-full border-collapse min-w-max">
                    <thead>
                        <tr>
                            <th class="sticky left-0 z-10 bg-gray-100 dark:bg-gray-800 p-2 text-left text-sm font-semibold text-gray-700 dark:text-gray-300 border border-gray-200 dark:border-gray-700 min-w-[140px]">
                                Kendaraan
                            </th>
                            @foreach($this->getDaysInMonth() as $day)
                                <th class="p-1 text-center text-xs font-medium border border-gray-200 dark:border-gray-700 min-w-[36px]
                                    {{ $day['isToday'] ? 'bg-primary-100 dark:bg-primary-900/30' : ($day['isWeekend'] ? 'bg-gray-50 dark:bg-gray-800/50' : 'bg-white dark:bg-gray-900') }}
                                    {{ $day['isToday'] ? 'text-primary-700 dark:text-primary-400' : 'text-gray-600 dark:text-gray-400' }}"
                                >
                                    <div class="flex flex-col">
                                        <span class="text-[10px]">{{ $day['dayName'] }}</span>
                                        <span class="{{ $day['isToday'] ? 'font-bold' : '' }}">{{ $day['day'] }}</span>
                                    </div>
                                </th>
                            @endforeach
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($this->getAllVehiclesWithBookings() as $vehicle)
                            <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/50">
                                <td class="sticky left-0 z-10 bg-white dark:bg-gray-900 p-2 border border-gray-200 dark:border-gray-700">
                                    <div class="flex flex-col">
                                        <span class="font-semibold text-sm text-gray-900 dark:text-white">
                                            {{ $vehicle['name'] }}
                                        </span>
                                        <span class="text-xs text-gray-500 dark:text-gray-400">
                                            {{ $vehicle['full_name'] }}
                                        </span>
                                    </div>
                                </td>
                                @foreach($this->getDaysInMonth() as $day)
                                    @php
                                        $dayData = $vehicle['days'][$day['date']] ?? ['isBooked' => false, 'booking' => null];
                                        $booking = $dayData['booking'];
                                    @endphp
                                    <td
                                        class="p-0 border border-gray-200 dark:border-gray-700 text-center
                                            {{ $day['isToday'] ? 'bg-primary-50 dark:bg-primary-900/20' : ($day['isWeekend'] ? 'bg-gray-50 dark:bg-gray-800/30' : '') }}"
                                        @if($booking)
                                            title="{{ $booking['user'] }}: {{ $booking['destination'] }} ({{ $booking['start'] }} - {{ $booking['end'] }})"
                                            x-data x-tooltip.raw="{{ $booking['user'] }}: {{ $booking['destination'] }}"
                                        @endif
                                    >
                                        @if($dayData['isBooked'])
                                            <div
                                                class="w-full h-8 flex items-center justify-center cursor-pointer hover:opacity-80"
                                                style="background-color: {{ $booking['status'] === 'in_use' ? 'rgb(234 179 8)' : 'rgb(239 68 68)' }};"
                                            >
                                                <x-heroicon-m-x-mark class="w-4 h-4 text-white" />
                                            </div>
                                        @else
                                            <div
                                                class="w-full h-8 flex items-center justify-center cursor-pointer hover:opacity-80"
                                                style="background-color: rgba(34, 197, 94, 0.2);"
                                            >
                                                <svg class="w-4 h-4" style="color: rgb(34 197 94);" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                </svg>
                                            </div>
                                        @endif
                                    </td>
                                @endforeach
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>

            @if(count($this->getAllVehiclesWithBookings()) === 0)
                <div class="text-center py-12 text-gray-500 dark:text-gray-400">
                    <x-heroicon-o-truck class="w-16 h-16 mx-auto mb-4 opacity-50" />
                    <p class="text-lg">Belum ada kendaraan terdaftar</p>
                    <p class="text-sm">Tambahkan kendaraan terlebih dahulu di menu Master Kendaraan</p>
                </div>
            @endif
        </x-filament::section>

        {{-- Quick Info --}}
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            @php
                $today = now()->format('Y-m-d');
                $vehicles = $this->getAllVehiclesWithBookings();
                $availableToday = collect($vehicles)->filter(fn($v) => !($v['days'][$today]['isBooked'] ?? false))->count();
                $bookedToday = collect($vehicles)->filter(fn($v) => $v['days'][$today]['isBooked'] ?? false)->count();
            @endphp

            <x-filament::section>
                <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 dark:text-success-400">{{ $availableToday }}</div>
                    <div class="text-sm text-gray-600 dark:text-gray-400">Tersedia Hari Ini</div>
                </div>
            </x-filament::section>

            <x-filament::section>
                <div class="text-center">
                    <div class="text-3xl font-bold text-danger-600 dark:text-danger-400">{{ $bookedToday }}</div>
                    <div class="text-sm text-gray-600 dark:text-gray-400">Digunakan Hari Ini</div>
                </div>
            </x-filament::section>

            <x-filament::section>
                <div class="text-center">
                    <div class="text-3xl font-bold text-primary-600 dark:text-primary-400">{{ count($vehicles) }}</div>
                    <div class="text-sm text-gray-600 dark:text-gray-400">Total Kendaraan Aktif</div>
                </div>
            </x-filament::section>
        </div>
    </div>
</x-filament-panels::page>
