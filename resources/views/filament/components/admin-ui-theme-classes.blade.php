@php
    $classes = auth()->user()
        ? \App\Http\Middleware\ApplyUserThemeColor::resolveUiClasses(auth()->user())
        : [];
@endphp

@if($classes !== [])
    <script>
        document.body.classList.add(...@js($classes));
    </script>
@endif
