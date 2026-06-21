<?php

use Illuminate\Support\Facades\Schedule;

Schedule::command('tickets:auto-close')
    ->daily()
    ->at('06:00')
    ->description('Auto-close resolved tickets after 3 days without rating');
