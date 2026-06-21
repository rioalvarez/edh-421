<x-filament-widgets::widget>
    @if($visible)
        <x-filament::section>
            @if($canRate)
                {{-- Rating form for reporter --}}
                <div class="space-y-4">
                    <div class="flex items-center gap-2">
                        <x-heroicon-s-star class="w-5 h-5 text-amber-500" />
                        <h3 class="text-base font-medium text-gray-900 dark:text-white">
                            Bagaimana penilaian Anda atas penyelesaian tiket ini?
                        </h3>
                    </div>

                    {{-- Star rating --}}
                    <div class="flex items-center gap-1">
                        @for($i = 1; $i <= 5; $i++)
                            <button
                                type="button"
                                wire:click="setScore({{ $i }})"
                                class="p-1 transition-transform hover:scale-110 focus:outline-none"
                            >
                                <svg class="w-8 h-8 {{ $score >= $i ? 'text-amber-400' : 'text-gray-300 dark:text-gray-600' }} transition-colors"
                                     fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                                </svg>
                            </button>
                        @endfor
                        @if($score > 0)
                            <span class="ml-2 text-sm text-gray-500 dark:text-gray-400">{{ $score }}/5</span>
                        @endif
                    </div>

                    {{-- Feedback textarea --}}
                    <div>
                        <label for="rating-feedback" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                            Komentar (opsional)
                        </label>
                        <textarea
                            id="rating-feedback"
                            wire:model="feedback"
                            rows="2"
                            maxlength="500"
                            placeholder="Ceritakan pengalaman Anda..."
                            class="fi-input block w-full rounded-lg border-gray-300 shadow-sm transition duration-75 focus:border-primary-500 focus:ring-1 focus:ring-inset focus:ring-primary-500 dark:border-gray-700 dark:bg-gray-900 dark:text-white dark:focus:border-primary-500 sm:text-sm"
                        ></textarea>
                    </div>

                    {{-- Submit button --}}
                    <div class="flex justify-end">
                        <x-filament::button
                            wire:click="submitRating"
                            :disabled="$score < 1"
                            color="success"
                            icon="heroicon-o-paper-airplane"
                        >
                            Kirim Penilaian
                        </x-filament::button>
                    </div>
                </div>
            @elseif($existingRating)
                {{-- Read-only rating display --}}
                <div class="flex items-center gap-3">
                    <div class="flex items-center gap-1">
                        @for($i = 1; $i <= 5; $i++)
                            <svg class="w-5 h-5 {{ $existingRating->score >= $i ? 'text-amber-400' : 'text-gray-300 dark:text-gray-600' }}"
                                 fill="currentColor" viewBox="0 0 24 24">
                                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                            </svg>
                        @endfor
                    </div>
                    <span class="text-sm text-gray-600 dark:text-gray-400">
                        Penilaian dari pelapor: {{ $existingRating->score }}/5
                    </span>
                    @if($existingRating->feedback)
                        <span class="text-sm text-gray-500 dark:text-gray-400 italic">
                            — "{{ $existingRating->feedback }}"
                        </span>
                    @endif
                </div>
            @endif
        </x-filament::section>
    @endif
</x-filament-widgets::widget>
