<x-filament-panels::page>
    @php
        $devices = $this->getDevices();

        $printerConn = [
            'USB' => 'USB', 'Network' => 'Jaringan (LAN)', 'Wireless' => 'Wireless / WiFi', 'Bluetooth' => 'Bluetooth',
        ];
        // Kelas badge ditulis literal (bukan dinamis) agar ter-scan & ter-compile Tailwind.
        $badgeClass = [
            'success' => 'bg-success-50 text-success-700 dark:bg-success-950 dark:text-success-300',
            'info'    => 'bg-info-50 text-info-700 dark:bg-info-950 dark:text-info-300',
            'warning' => 'bg-warning-50 text-warning-700 dark:bg-warning-950 dark:text-warning-300',
            'danger'  => 'bg-danger-50 text-danger-700 dark:bg-danger-950 dark:text-danger-300',
            'gray'    => 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-300',
        ];
    @endphp

    <div class="space-y-5">
        <p class="-mt-2 text-sm text-gray-500 dark:text-gray-400">
            Spesifikasi perangkat IT yang terdaftar atas nama Anda.
        </p>

        @forelse ($devices as $device)
            @php
                $isKomputer = in_array($device->type, ['laptop', 'desktop', 'all-in-one', 'workstation']);
                $isPrinter  = in_array($device->type, ['printer', 'scanner']);
                $storage    = trim(($device->storage_capacity ?? '') . ' ' . ($device->storage_type ?? ''));

                $specs = collect([
                    'Merek'      => $device->brand,
                    'Model'      => $device->model,
                    'Nomor Seri' => $device->serial_number,
                    'Tag Aset'   => $device->asset_tag,
                    'Lokasi'     => $device->location,
                    'Unit Penanggung Jawab' => $device->unit?->name,
                ]);

                if ($isKomputer) {
                    $specs = $specs->merge([
                        'Sistem Operasi' => $device->os,
                        'Versi OS'       => $device->os_version,
                        'Prosesor'       => $device->processor,
                        'RAM'            => $device->ram,
                        'Penyimpanan'    => $storage ?: null,
                    ]);
                }

                if ($isPrinter) {
                    $specs = $specs->merge([
                        'Jenis Koneksi' => $printerConn[$device->printer_connection] ?? $device->printer_connection,
                        'Fungsi'        => $device->printer_function,
                    ]);
                }

                $specs = $specs->merge([
                    'IP Address'  => $device->ip_address,
                    'MAC Address' => $device->mac_address,
                ]);

                foreach ($device->attributeValues as $av) {
                    if ($av->attribute && ($av->attribute->is_active ?? true) && filled($av->value)) {
                        $specs->put($av->attribute->name, $av->value);
                    }
                }

                $specs = $specs->filter(fn ($v) => filled($v));

                $condLabel = \App\Enums\DeviceCondition::tryLabel($device->condition);
                $condColor = \App\Enums\DeviceCondition::tryColor($device->condition);
                $statLabel = \App\Enums\DeviceStatus::tryLabel($device->status);
                $statColor = \App\Enums\DeviceStatus::tryColor($device->status);

                $warrantyExpired = $device->warranty_expiry && $device->warranty_expiry->isPast();
            @endphp

            <section class="overflow-hidden rounded-xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-900">
                {{-- Header --}}
                <div class="flex flex-wrap items-start justify-between gap-3 border-b border-gray-100 px-5 py-4 dark:border-gray-800">
                    <div class="flex min-w-0 items-center gap-3">
                        <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-primary-50 text-primary-600 dark:bg-primary-950 dark:text-primary-400">
                            <x-heroicon-o-cpu-chip class="h-5 w-5" />
                        </div>
                        <div class="min-w-0">
                            <h3 class="break-words text-base font-semibold leading-tight text-gray-900 dark:text-white">
                                {{ $device->display_name }}
                            </h3>
                            <p class="mt-0.5 text-xs text-gray-500 dark:text-gray-400">
                                {{ \App\Enums\DeviceType::tryLabel($device->type) }}
                            </p>
                        </div>
                    </div>

                    <div class="flex flex-wrap items-center gap-2">
                        <span class="inline-flex items-center rounded-md px-2 py-1 text-xs font-medium {{ $badgeClass[$statColor] }}">
                            {{ $statLabel }}
                        </span>
                        <span class="inline-flex items-center rounded-md px-2 py-1 text-xs font-medium {{ $badgeClass[$condColor] }}">
                            {{ $condLabel }}
                        </span>
                    </div>
                </div>

                {{-- Spesifikasi --}}
                <dl class="grid grid-cols-2 gap-x-6 gap-y-4 px-5 py-5 sm:grid-cols-3 lg:grid-cols-4">
                    @foreach ($specs as $label => $value)
                        <div class="min-w-0">
                            <dt class="text-xs font-medium uppercase tracking-wide text-gray-400 dark:text-gray-500">
                                {{ $label }}
                            </dt>
                            <dd class="mt-1 break-words text-sm font-medium text-gray-900 dark:text-gray-100">
                                {{ $value }}
                            </dd>
                        </div>
                    @endforeach
                </dl>

                {{-- Garansi --}}
                @if ($device->purchase_date || $device->warranty_expiry)
                    <div class="flex flex-wrap items-center gap-x-8 gap-y-2 border-t border-gray-100 px-5 py-3 text-xs dark:border-gray-800">
                        @if ($device->purchase_date)
                            <span class="text-gray-500 dark:text-gray-400">
                                Dibeli: <span class="font-medium text-gray-700 dark:text-gray-300">{{ $device->purchase_date->format('d M Y') }}</span>
                            </span>
                        @endif
                        @if ($device->warranty_expiry)
                            <span class="flex items-center gap-1.5 {{ $warrantyExpired ? 'text-danger-600 dark:text-danger-400' : 'text-gray-500 dark:text-gray-400' }}">
                                @if ($warrantyExpired)
                                    <x-heroicon-o-exclamation-triangle class="h-4 w-4" />
                                @endif
                                Garansi {{ $warrantyExpired ? 'berakhir' : 'sampai' }}:
                                <span class="font-medium {{ $warrantyExpired ? 'text-danger-600 dark:text-danger-400' : 'text-gray-700 dark:text-gray-300' }}">
                                    {{ $device->warranty_expiry->format('d M Y') }}
                                </span>
                            </span>
                        @endif
                    </div>
                @endif
            </section>
        @empty
            <div class="flex flex-col items-center justify-center rounded-xl border border-dashed border-gray-300 px-6 py-16 text-center dark:border-gray-700">
                <div class="flex h-12 w-12 items-center justify-center rounded-full bg-gray-100 text-gray-400 dark:bg-gray-800 dark:text-gray-500">
                    <x-heroicon-o-cpu-chip class="h-6 w-6" />
                </div>
                <h3 class="mt-4 text-sm font-semibold text-gray-900 dark:text-white">Belum ada perangkat</h3>
                <p class="mt-1 max-w-sm text-sm text-gray-500 dark:text-gray-400">
                    Saat ini tidak ada perangkat IT yang terdaftar atas nama Anda. Hubungi tim IT jika ada perangkat yang seharusnya tercatat di sini.
                </p>
            </div>
        @endforelse
    </div>
</x-filament-panels::page>
