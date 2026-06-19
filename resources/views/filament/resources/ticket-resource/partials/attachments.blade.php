<div class="grid grid-cols-2 md:grid-cols-4 gap-4">
    @foreach($attachments as $attachment)
        <a href="{{ $attachment->url }}" target="_blank" class="group">
            <div class="relative aspect-square rounded-lg overflow-hidden bg-gray-100 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 hover:border-primary-500 transition-colors">
                @if($attachment->isImage())
                    <img
                        src="{{ $attachment->url }}"
                        alt="{{ $attachment->file_name }}"
                        class="w-full h-full object-cover group-hover:scale-105 transition-transform"
                    />
                @else
                    <div class="flex flex-col items-center justify-center h-full p-4">
                        <x-heroicon-o-document class="w-12 h-12 text-gray-400" />
                        <span class="text-xs text-gray-500 mt-2 truncate max-w-full">{{ $attachment->file_name }}</span>
                    </div>
                @endif
                <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                    <x-heroicon-o-arrow-top-right-on-square class="w-6 h-6 text-white" />
                </div>
            </div>
            <p class="text-xs text-gray-500 mt-1 truncate">{{ $attachment->file_size_formatted }}</p>
        </a>
    @endforeach
</div>
