<?php

namespace App\Filament\Widgets;

use App\Enums\VehicleBookingStatus;
use App\Filament\Concerns\HasModuleWidgetGate;
use App\Models\Vehicle;
use App\Models\VehicleBooking;
use Filament\Widgets\Widget;
use Illuminate\Support\Carbon;

class VehicleAvailabilityCalendar extends Widget
{
    use HasModuleWidgetGate;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::VEHICLES_CALENDAR;

    protected static string $view = 'filament.widgets.vehicle-availability-calendar';

    protected static ?string $heading = 'Kalender Ketersediaan Kendaraan';

    protected static ?int $sort = 2;

    protected int|string|array $columnSpan = 'full';

    // Implement canView method
    public static function canView(): bool
    {
        if (auth()->user()?->hasRole('Member')) {
            return false;
        }

        return static::passesModuleWidgetGate()
            && auth()->user()?->isItAdmin() !== true;
    }

    public ?int $selectedVehicleId = null;

    public string $currentMonth;

    public function mount(): void
    {
        $this->currentMonth = now()->format('Y-m');
        $this->selectedVehicleId = Vehicle::available()->first()?->id;
    }

    public function getVehicles(): array
    {
        return Vehicle::active()
            ->get()
            ->mapWithKeys(fn ($v) => [$v->id => "{$v->plate_number} - {$v->brand} {$v->model}"])
            ->toArray();
    }

    public function getCalendarData(): array
    {
        $startOfMonth = Carbon::parse($this->currentMonth)->startOfMonth();
        $endOfMonth = Carbon::parse($this->currentMonth)->endOfMonth();

        $bookings = [];

        if ($this->selectedVehicleId) {
            $bookings = VehicleBooking::where('vehicle_id', $this->selectedVehicleId)
                ->whereIn('status', VehicleBookingStatus::activeValues())
                ->where(function ($q) use ($startOfMonth, $endOfMonth) {
                    $q->whereBetween('start_date', [$startOfMonth, $endOfMonth])
                        ->orWhereBetween('end_date', [$startOfMonth, $endOfMonth])
                        ->orWhere(function ($q2) use ($startOfMonth, $endOfMonth) {
                            $q2->where('start_date', '<=', $startOfMonth)
                                ->where('end_date', '>=', $endOfMonth);
                        });
                })
                ->with('user')
                ->get();
        }

        // Build calendar grid
        $calendar = [];
        $current = $startOfMonth->copy()->startOfWeek(Carbon::MONDAY);
        $endOfCalendar = $endOfMonth->copy()->endOfWeek(Carbon::SUNDAY);

        // Pre-index bookings by date for O(1) lookup instead of O(n) filter per day
        $bookingsByDate = [];
        if ($bookings instanceof \Illuminate\Support\Collection) {
            foreach ($bookings as $booking) {
                $bStart = $booking->start_date->copy()->max($startOfMonth->copy()->startOfWeek(Carbon::MONDAY));
                $bEnd = $booking->end_date->copy()->min($endOfMonth->copy()->endOfWeek(Carbon::SUNDAY));
                $d = $bStart->copy();
                while ($d <= $bEnd) {
                    $bookingsByDate[$d->format('Y-m-d')][] = $booking;
                    $d->addDay();
                }
            }
        }

        while ($current <= $endOfCalendar) {
            $week = [];
            for ($i = 0; $i < 7; $i++) {
                $date = $current->copy();
                $dateKey = $date->format('Y-m-d');
                $isCurrentMonth = $date->month === $startOfMonth->month;
                $isToday = $date->isToday();
                $isPast = $date->isPast() && ! $isToday;

                $dayBookings = $bookingsByDate[$dateKey] ?? [];

                $week[] = [
                    'date' => $dateKey,
                    'day' => $date->day,
                    'isCurrentMonth' => $isCurrentMonth,
                    'isToday' => $isToday,
                    'isPast' => $isPast,
                    'isBooked' => count($dayBookings) > 0,
                    'bookings' => collect($dayBookings)->map(fn (VehicleBooking $b) => [
                        'id' => $b->id,
                        'user' => $b->user->name,
                        'destination' => $b->destination,
                        'status' => $b->status,
                    ])->values()->toArray(),
                ];

                $current->addDay();
            }
            $calendar[] = $week;
        }

        return $calendar;
    }

    public function previousMonth(): void
    {
        $this->currentMonth = Carbon::parse($this->currentMonth)->subMonth()->format('Y-m');
    }

    public function nextMonth(): void
    {
        $this->currentMonth = Carbon::parse($this->currentMonth)->addMonth()->format('Y-m');
    }

    public function getCurrentMonthLabel(): string
    {
        return Carbon::parse($this->currentMonth)->translatedFormat('F Y');
    }

    public function updatedSelectedVehicleId(): void
    {
        // Refresh calendar when vehicle changes
    }
}
