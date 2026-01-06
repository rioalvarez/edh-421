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
        Schema::create('vehicles', function (Blueprint $table) {
            $table->id();
            $table->string('plate_number')->unique(); // Nomor plat kendaraan
            $table->string('brand'); // Merk (Toyota, Honda, dll)
            $table->string('model'); // Model (Avanza, Innova, dll)
            $table->year('year')->nullable(); // Tahun kendaraan
            $table->string('color')->nullable(); // Warna
            $table->unsignedTinyInteger('capacity')->default(4); // Kapasitas penumpang
            $table->enum('fuel_type', ['bensin', 'solar', 'listrik'])->default('bensin');
            $table->enum('ownership', ['dinas', 'sewa'])->default('dinas'); // Status kepemilikan
            $table->enum('condition', ['excellent', 'good', 'fair', 'poor'])->default('good');
            $table->enum('status', ['available', 'in_use', 'maintenance', 'retired'])->default('available');
            $table->date('last_service_date')->nullable(); // Tanggal servis terakhir
            $table->date('tax_expiry_date')->nullable(); // Tanggal pajak habis
            $table->date('inspection_expiry_date')->nullable(); // Tanggal KIR habis
            $table->string('image')->nullable(); // Foto kendaraan
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vehicles');
    }
};
