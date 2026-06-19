<?php

namespace App\Filament\Modules\Helpdesk\Pages;

use App\Filament\Concerns\HasModuleNavigationGate;
use App\Models\Ticket;
use App\Services\Helpdesk\TicketReportService;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Select;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Form;
use Filament\Pages\Page;
use Illuminate\Database\Eloquent\Collection as EloquentCollection;

class TicketReport extends Page implements HasForms
{
    use HasModuleNavigationGate;
    use InteractsWithForms;

    protected static ?string $moduleNavigationKey = \App\Filament\Support\ModuleNavigationRegistry::HELPDESK_REPORT;

    protected static ?string $navigationIcon = 'heroicon-o-document-chart-bar';

    protected static ?string $navigationGroup = 'IT Helpdesk';

    protected static string $view = 'filament.pages.ticket-report';

    protected static ?int $navigationSort = 2;

    protected static ?string $navigationLabel = 'Laporan Tiket';

    protected static ?string $title = 'Laporan Tiket IT Helpdesk';

    public ?string $period = 'monthly';

    public ?string $startDate = null;

    public ?string $endDate = null;

    private ?TicketReportService $reportService = null;

    public function mount(): void
    {
        $this->setPeriodDates();
    }

    public static function shouldRegisterNavigation(): bool
    {
        return static::canAccess();
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Section::make('Filter Laporan')
                    ->schema([
                        Select::make('period')
                            ->label('Periode')
                            ->options([
                                'weekly' => 'Mingguan',
                                'monthly' => 'Bulanan',
                                'quarterly' => 'Triwulanan',
                                'yearly' => 'Tahunan',
                                'custom' => 'Kustom',
                            ])
                            ->default('monthly')
                            ->live()
                            ->afterStateUpdated(fn () => $this->setPeriodDates()),

                        DatePicker::make('startDate')
                            ->label('Tanggal Mulai')
                            ->visible(fn () => $this->period === 'custom')
                            ->live()
                            ->afterStateUpdated(fn () => $this->loadReport()),

                        DatePicker::make('endDate')
                            ->label('Tanggal Akhir')
                            ->visible(fn () => $this->period === 'custom')
                            ->live()
                            ->afterStateUpdated(fn () => $this->loadReport()),
                    ])
                    ->columns(3),
            ]);
    }

    public function setPeriodDates(): void
    {
        $dates = $this->reportService()->periodDates($this->period, $this->startDate, $this->endDate);

        $this->startDate = $dates['start'];
        $this->endDate = $dates['end'];
    }

    public function loadReport(): void
    {
        // Trigger re-render
    }

    public function getStatistics(): array
    {
        return $this->reportService()->statistics($this->startDate, $this->endDate);
    }

    public function getCategoryStatistics(): array
    {
        return $this->reportService()->categoryStatistics($this->startDate, $this->endDate);
    }

    public function getPriorityStatistics(): array
    {
        return $this->reportService()->priorityStatistics($this->startDate, $this->endDate);
    }

    public function getTopReporters(): array
    {
        return $this->reportService()->topReporters($this->startDate, $this->endDate);
    }

    public function getTopHandlers(): array
    {
        return $this->reportService()->topHandlers($this->startDate, $this->endDate);
    }

    public function getAgentWorkload(): EloquentCollection
    {
        return $this->reportService()->agentWorkload();
    }

    /**
     * @return EloquentCollection<int, Ticket>
     */
    public function getTickets(): EloquentCollection
    {
        return $this->reportService()->tickets($this->startDate, $this->endDate);
    }

    public function getPeriodLabel(): string
    {
        return $this->reportService()->periodLabel($this->startDate, $this->endDate);
    }

    public function getCategoryLabel(string $category): string
    {
        return $this->reportService()->categoryLabel($category);
    }

    public function getPriorityLabel(string $priority): string
    {
        return $this->reportService()->priorityLabel($priority);
    }

    public function getStatusLabel(string $status): string
    {
        return $this->reportService()->statusLabel($status);
    }

    public function exportExcel()
    {
        $filename = 'laporan-tiket-'.$this->startDate.'-to-'.$this->endDate.'.csv';

        $headers = [
            'Content-Type' => 'text/csv',
            'Content-Disposition' => "attachment; filename=\"{$filename}\"",
        ];

        $callback = function () {
            $file = fopen('php://output', 'w');

            // Add BOM for Excel UTF-8 compatibility
            fprintf($file, chr(0xEF).chr(0xBB).chr(0xBF));

            // Header
            fputcsv($file, [
                'No. Tiket',
                'Tanggal',
                'Pelapor',
                'Kategori',
                'Prioritas',
                'Subjek',
                'Status',
                'Ditugaskan Ke',
                'Waktu Penyelesaian',
            ]);

            // Data
            foreach ($this->reportService()->lazyTickets($this->startDate, $this->endDate) as $ticket) {
                fputcsv($file, [
                    $ticket->ticket_number,
                    $ticket->created_at->format('d/m/Y H:i'),
                    $ticket->user->name ?? '-',
                    $this->getCategoryLabel($ticket->category),
                    $this->getPriorityLabel($ticket->priority),
                    $ticket->subject,
                    $this->getStatusLabel($ticket->status),
                    $ticket->assignedTo->name ?? '-',
                    $ticket->resolved_at ? $ticket->resolved_at->format('d/m/Y H:i') : '-',
                ]);
            }

            fclose($file);
        };

        return response()->stream($callback, 200, $headers);
    }

    public static function canAccess(): bool
    {
        return static::passesModuleNavigationGate()
            && auth()->user()->isSuperAdmin();
    }

    private function reportService(): TicketReportService
    {
        return $this->reportService ??= app(TicketReportService::class);
    }
}
