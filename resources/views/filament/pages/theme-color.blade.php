<x-filament-panels::page>
    <div class="space-y-6">
        <x-filament::section>
            <x-slot name="heading">Warna</x-slot>
            <x-slot name="description">Aksen utama dan tone dasar panel admin.</x-slot>

            <div class="space-y-6">
                <div>
                    <div class="mb-3 flex items-center justify-between gap-3">
                        <div>
                            <h3 class="text-sm font-semibold text-gray-950 dark:text-white">Warna Aksen</h3>
                            <p class="text-sm text-gray-500 dark:text-gray-400">Tombol, link aktif, dan elemen interaktif.</p>
                        </div>
                        <span class="text-sm font-medium text-gray-700 dark:text-gray-300">
                            {{ $this->getPrimaryColors()[$selectedColor]['label'] ?? 'Amber' }}
                        </span>
                    </div>

                    <div class="flex flex-wrap gap-3">
                        @foreach($this->getPrimaryColors() as $key => $color)
                            <x-ui.swatch-button
                                wire:click="selectColor('{{ $key }}')"
                                wire:loading.attr="disabled"
                                :selected="$selectedColor === $key"
                                :color="$color['hex']"
                                :label="$color['label']"
                            />
                        @endforeach
                    </div>
                </div>

                <div>
                    <div class="mb-3 flex items-center justify-between gap-3">
                        <div>
                            <h3 class="text-sm font-semibold text-gray-950 dark:text-white">Tone Dasar</h3>
                            <p class="text-sm text-gray-500 dark:text-gray-400">Nuansa background, sidebar, dan card.</p>
                        </div>
                        <span class="text-sm font-medium text-gray-700 dark:text-gray-300">
                            {{ $this->getGrayTones()[$selectedGray]['label'] ?? 'Slate' }}
                        </span>
                    </div>

                    <div class="flex flex-wrap gap-3">
                        @foreach($this->getGrayTones() as $key => $tone)
                            <x-ui.swatch-button
                                wire:click="selectGray('{{ $key }}')"
                                wire:loading.attr="disabled"
                                :selected="$selectedGray === $key"
                                :color="$tone['shades'][$selectedLevel - 1]"
                                :label="$tone['label']"
                            />
                        @endforeach
                    </div>
                </div>

                <div>
                    <div class="mb-3">
                        <h3 class="text-sm font-semibold text-gray-950 dark:text-white">Intensitas</h3>
                        <p class="text-sm text-gray-500 dark:text-gray-400">Tingkat kegelapan tone dasar.</p>
                    </div>

                    @php $toneShades = $this->getGrayTones()[$selectedGray]['shades'] ?? ['#cbd5e1','#64748b','#334155','#0f172a']; @endphp

                    <div class="flex flex-wrap gap-3">
                        @foreach($this->getIntensityLevels() as $level => $label)
                            <x-ui.button
                                variant="ghost"
                                size="sm"
                                wire:click="selectLevel({{ $level }})"
                                wire:loading.attr="disabled"
                                class="group flex items-center gap-2 rounded-lg px-2 py-1.5 text-sm transition hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-primary-500 dark:hover:bg-white/5 {{ $selectedLevel === $level ? 'bg-gray-50 font-semibold text-gray-950 ring-1 ring-gray-200 dark:bg-white/5 dark:text-white dark:ring-white/10' : 'text-gray-600 dark:text-gray-400' }}"
                            >
                                <span
                                    class="h-5 w-5 rounded-full shadow-sm"
                                    style="background-color: {{ $toneShades[$level - 1] }}"
                                ></span>
                                {{ $label }}
                            </x-ui.button>
                        @endforeach
                    </div>
                </div>
            </div>
        </x-filament::section>

        <x-filament::section>
            <x-slot name="heading">Layout Admin</x-slot>
            <x-slot name="description">Preset untuk navigasi dan ruang kerja utama.</x-slot>

            <div class="grid gap-6 xl:grid-cols-2">
                <div>
                    <h3 class="mb-3 text-sm font-semibold text-gray-950 dark:text-white">Sidebar</h3>
                    <div class="grid gap-3 sm:grid-cols-2">
                        @foreach($this->getSidebarStyles() as $key => $option)
                            <x-ui.option-card
                                wire:click="selectSidebarStyle('{{ $key }}')"
                                wire:loading.attr="disabled"
                                :selected="$selectedSidebarStyle === $key"
                            >
                                <span class="mb-3 block h-10 rounded-md ring-1 {{ $option['preview'] }}"></span>
                                <span class="flex items-center justify-between gap-3">
                                    <span class="text-sm font-semibold text-gray-950 dark:text-white">{{ $option['label'] }}</span>
                                    @if($selectedSidebarStyle === $key)
                                        <x-heroicon-o-check class="h-4 w-4 text-primary-600 dark:text-primary-400" />
                                    @endif
                                </span>
                                <span class="mt-1 block text-sm text-gray-500 dark:text-gray-400">{{ $option['description'] }}</span>
                            </x-ui.option-card>
                        @endforeach
                    </div>
                </div>

                <div>
                    <h3 class="mb-3 text-sm font-semibold text-gray-950 dark:text-white">Navbar</h3>
                    <div class="grid gap-3 sm:grid-cols-2">
                        @foreach($this->getNavbarStyles() as $key => $option)
                            <x-ui.option-card
                                wire:click="selectNavbarStyle('{{ $key }}')"
                                wire:loading.attr="disabled"
                                :selected="$selectedNavbarStyle === $key"
                            >
                                <span class="flex items-center justify-between gap-3">
                                    <span class="text-sm font-semibold text-gray-950 dark:text-white">{{ $option['label'] }}</span>
                                    @if($selectedNavbarStyle === $key)
                                        <x-heroicon-o-check class="h-4 w-4 text-primary-600 dark:text-primary-400" />
                                    @endif
                                </span>
                                <span class="mt-1 block text-sm text-gray-500 dark:text-gray-400">{{ $option['description'] }}</span>
                            </x-ui.option-card>
                        @endforeach
                    </div>
                </div>
            </div>
        </x-filament::section>

        <x-filament::section>
            <x-slot name="heading">Kerapatan & Konten</x-slot>
            <x-slot name="description">Sesuaikan layar admin untuk form biasa atau tabel besar.</x-slot>

            <div class="grid gap-6 xl:grid-cols-3">
                @foreach([
                    'selectDensity' => ['heading' => 'Density', 'selected' => $selectedDensity, 'options' => $this->getDensityOptions()],
                    'selectRadius' => ['heading' => 'Radius', 'selected' => $selectedRadius, 'options' => $this->getRadiusOptions()],
                    'selectContentWidth' => ['heading' => 'Lebar Konten', 'selected' => $selectedContentWidth, 'options' => $this->getContentWidthOptions()],
                ] as $method => $group)
                    <div>
                        <h3 class="mb-3 text-sm font-semibold text-gray-950 dark:text-white">{{ $group['heading'] }}</h3>
                        <div class="space-y-3">
                            @foreach($group['options'] as $key => $option)
                                <x-ui.option-card
                                    wire:click="{{ $method }}('{{ $key }}')"
                                    wire:loading.attr="disabled"
                                    class="w-full"
                                    :selected="$group['selected'] === $key"
                                >
                                    <span class="flex items-center justify-between gap-3">
                                        <span class="text-sm font-semibold text-gray-950 dark:text-white">{{ $option['label'] }}</span>
                                        @if($group['selected'] === $key)
                                            <x-heroicon-o-check class="h-4 w-4 text-primary-600 dark:text-primary-400" />
                                        @endif
                                    </span>
                                    <span class="mt-1 block text-sm text-gray-500 dark:text-gray-400">{{ $option['description'] }}</span>
                                </x-ui.option-card>
                            @endforeach
                        </div>
                    </div>
                @endforeach
            </div>
        </x-filament::section>
    </div>
</x-filament-panels::page>
