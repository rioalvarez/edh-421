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
        Schema::create('devices', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->enum('type', ['laptop', 'desktop', 'all-in-one', 'workstation'])->default('desktop');
            $table->string('hostname')->nullable();
            $table->string('ip_address')->nullable();
            $table->string('mac_address')->nullable();
            $table->string('os')->nullable();
            $table->string('os_version')->nullable();
            $table->string('processor')->nullable();
            $table->string('ram')->nullable();
            $table->enum('storage_type', ['SSD', 'HDD', 'NVMe', 'Hybrid'])->nullable();
            $table->string('storage_capacity')->nullable();
            $table->string('brand')->nullable();
            $table->string('model')->nullable();
            $table->string('serial_number')->nullable()->unique();
            $table->date('purchase_date')->nullable();
            $table->date('warranty_expiry')->nullable();
            $table->enum('condition', ['excellent', 'good', 'fair', 'poor', 'broken'])->default('good');
            $table->enum('status', ['active', 'inactive', 'maintenance', 'retired'])->default('active');
            $table->text('notes')->nullable();
            $table->string('location')->nullable();
            $table->string('asset_tag')->nullable()->unique();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('devices');
    }
};
