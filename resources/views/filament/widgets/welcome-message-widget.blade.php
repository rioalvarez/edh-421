<x-filament::widget>
    <x-filament::card>
        <div>
            <h2 class="text-2xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-3xl">
                Selamat Datang, {{ auth()->user()->name }}!
            </h2>
            <p class="mt-2 text-base leading-relaxed text-gray-600 dark:text-gray-400">
                Semangat bekerja! Setiap usaha kecil membawa kita lebih dekat pada tujuan besar.
            </p>
        </div>
    </x-filament::card>
</x-filament::widget>
