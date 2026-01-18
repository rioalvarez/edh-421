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
        // Tickets table indexes
        Schema::table('tickets', function (Blueprint $table) {
            $table->index('status');
            $table->index('priority');
            $table->index('category');
            $table->index('created_at');
            $table->index(['status', 'user_id']); // Composite for user's open tickets
            $table->index(['status', 'assigned_to']); // Composite for admin's assigned tickets
        });

        // Articles table indexes
        Schema::table('articles', function (Blueprint $table) {
            $table->index('status');
            $table->index('published_at');
            $table->index('views');
            $table->index(['status', 'published_at']); // Composite for published articles query
        });

        // Devices table indexes
        Schema::table('devices', function (Blueprint $table) {
            $table->index('status');
            $table->index('condition');
            $table->index('type');
            $table->index('location');
        });

        // Device attribute values table indexes
        Schema::table('device_attribute_values', function (Blueprint $table) {
            $table->index(['device_id', 'device_attribute_id']); // Composite for lookups
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tickets', function (Blueprint $table) {
            $table->dropIndex(['status']);
            $table->dropIndex(['priority']);
            $table->dropIndex(['category']);
            $table->dropIndex(['created_at']);
            $table->dropIndex(['status', 'user_id']);
            $table->dropIndex(['status', 'assigned_to']);
        });

        Schema::table('articles', function (Blueprint $table) {
            $table->dropIndex(['status']);
            $table->dropIndex(['published_at']);
            $table->dropIndex(['views']);
            $table->dropIndex(['status', 'published_at']);
        });

        Schema::table('devices', function (Blueprint $table) {
            $table->dropIndex(['status']);
            $table->dropIndex(['condition']);
            $table->dropIndex(['type']);
            $table->dropIndex(['location']);
        });

        Schema::table('device_attribute_values', function (Blueprint $table) {
            $table->dropIndex(['device_id', 'device_attribute_id']);
        });
    }
};
