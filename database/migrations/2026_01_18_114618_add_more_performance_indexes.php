<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Vehicle bookings indexes
        Schema::table('vehicle_bookings', function (Blueprint $table) {
            $table->index('status');
            $table->index('user_id');
            $table->index('vehicle_id');
            $table->index('start_date');
            $table->index('end_date');
            $table->index(['status', 'user_id']); // For user's bookings
            $table->index(['status', 'end_date', 'returned_at']); // For needs return query
            $table->index(['vehicle_id', 'status', 'start_date', 'end_date']); // For availability check
        });

        // Vehicles indexes
        Schema::table('vehicles', function (Blueprint $table) {
            $table->index('status');
            $table->index('plate_number');
        });

        // Users indexes (if not exists)
        Schema::table('users', function (Blueprint $table) {
            $table->index('email');
        });

        // Ticket responses indexes
        Schema::table('ticket_responses', function (Blueprint $table) {
            $table->index('ticket_id');
            $table->index('user_id');
            $table->index(['ticket_id', 'created_at']); // For ordered responses
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('vehicle_bookings', function (Blueprint $table) {
            $table->dropIndex(['status']);
            $table->dropIndex(['user_id']);
            $table->dropIndex(['vehicle_id']);
            $table->dropIndex(['start_date']);
            $table->dropIndex(['end_date']);
            $table->dropIndex(['status', 'user_id']);
            $table->dropIndex(['status', 'end_date', 'returned_at']);
            $table->dropIndex(['vehicle_id', 'status', 'start_date', 'end_date']);
        });

        Schema::table('vehicles', function (Blueprint $table) {
            $table->dropIndex(['status']);
            $table->dropIndex(['plate_number']);
        });

        Schema::table('users', function (Blueprint $table) {
            $table->dropIndex(['email']);
        });

        Schema::table('ticket_responses', function (Blueprint $table) {
            $table->dropIndex(['ticket_id']);
            $table->dropIndex(['user_id']);
            $table->dropIndex(['ticket_id', 'created_at']);
        });
    }
};
