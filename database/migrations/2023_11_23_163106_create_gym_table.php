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
        Schema::create('gym', function (Blueprint $table) {
            $table->id('id_gym');
            $table->text('description');
            $table->longText('facilities');
            $table->string('name');
            $table->string('location');
            $table->string('image');
            $table->longText('packages');
            $table->string('place');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('gym');
    }
};
