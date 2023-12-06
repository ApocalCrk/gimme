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
        Schema::create('transactions', function (Blueprint $table) {
            $table->id('id_transaction');
            $table->foreignId('uid')->references('uid')->on('users');
            $table->foreignId('id_gym')->references('id_gym')->on('gym');
            $table->string('payment_method');
            $table->string('payment_status');
            $table->integer('payment_amount');
            $table->string('bundle');
            $table->string('type_membership');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transactions');
    }
};
