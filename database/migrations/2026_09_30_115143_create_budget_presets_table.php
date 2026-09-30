<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('budget_presets', function (Blueprint $table) {
            $table->id();
            $table->string('name');                 // mis. "Populer 50/30/20"
            $table->unsignedTinyInteger('food_pct');
            $table->unsignedTinyInteger('operational_pct');
            $table->unsignedTinyInteger('healing_pct');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('budget_presets');
    }
};