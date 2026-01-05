<div class="space-y-4">
    {{-- Chat Messages --}}
    <div class="bg-gray-50 dark:bg-gray-900 rounded-lg p-4 max-h-96 overflow-y-auto space-y-4">
        @forelse($responses as $response)
            @php
                $isCurrentUser = $response->user_id === auth()->id();
                $isAdmin = $response->user->hasRole('super_admin');
            @endphp
            <div class="flex {{ $isCurrentUser ? 'justify-end' : 'justify-start' }}">
                <div class="max-w-[80%] {{ $isCurrentUser ? 'order-2' : 'order-1' }}">
                    {{-- Avatar & Name --}}
                    <div class="flex items-center gap-2 mb-1 {{ $isCurrentUser ? 'justify-end' : 'justify-start' }}">
                        @if(!$isCurrentUser)
                            <div class="w-6 h-6 rounded-full bg-primary-500 flex items-center justify-center text-white text-xs font-bold">
                                {{ strtoupper(substr($response->user->name, 0, 1)) }}
                            </div>
                        @endif
                        <span class="text-xs font-medium text-gray-600 dark:text-gray-400">
                            {{ $response->user->name }}
                            @if($isAdmin)
                                <span class="inline-flex items-center px-1.5 py-0.5 rounded text-xs font-medium bg-primary-100 text-primary-800 dark:bg-primary-900 dark:text-primary-200">
                                    IT Support
                                </span>
                            @endif
                        </span>
                        @if($response->is_internal_note)
                            <span class="inline-flex items-center px-1.5 py-0.5 rounded text-xs font-medium bg-yellow-100 text-yellow-800">
                                Internal
                            </span>
                        @endif
                    </div>

                    {{-- Message Bubble --}}
                    <div class="rounded-2xl px-4 py-2 {{ $isCurrentUser ? 'bg-primary-500 text-white rounded-br-md' : 'bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-bl-md shadow' }}">
                        <div class="prose prose-sm dark:prose-invert max-w-none {{ $isCurrentUser ? 'prose-invert' : '' }}">
                            {!! $response->message !!}
                        </div>
                    </div>

                    {{-- Timestamp --}}
                    <div class="text-xs text-gray-400 mt-1 {{ $isCurrentUser ? 'text-right' : 'text-left' }}">
                        {{ $response->created_at->format('d M Y, H:i') }}
                    </div>
                </div>
            </div>
        @empty
            <div class="text-center py-8 text-gray-500">
                <x-heroicon-o-chat-bubble-left-right class="w-12 h-12 mx-auto mb-2 opacity-50" />
                <p>Belum ada tanggapan</p>
            </div>
        @endforelse
    </div>

    {{-- Input Form --}}
    @if($ticket->status !== 'closed')
        <form wire:submit="sendMessage" class="mt-4">
            <div class="flex gap-2">
                <div class="flex-1">
                    <textarea
                        wire:model="message"
                        rows="2"
                        class="w-full rounded-lg border-gray-300 dark:border-gray-700 dark:bg-gray-800 dark:text-white shadow-sm focus:border-primary-500 focus:ring-primary-500"
                        placeholder="Tulis pesan..."
                    ></textarea>
                    @error('message')
                        <span class="text-red-500 text-xs">{{ $message }}</span>
                    @enderror
                </div>
                <button
                    type="submit"
                    class="px-4 py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600 transition-colors self-end"
                >
                    <x-heroicon-o-paper-airplane class="w-5 h-5" />
                </button>
            </div>
        </form>
    @else
        <div class="text-center py-4 text-gray-500 bg-gray-100 dark:bg-gray-800 rounded-lg">
            <x-heroicon-o-lock-closed class="w-5 h-5 mx-auto mb-1" />
            <p class="text-sm">Tiket sudah ditutup</p>
        </div>
    @endif
</div>
