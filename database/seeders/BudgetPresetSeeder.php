<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\BudgetPreset;

class BudgetPresetSeeder extends Seeder
{
    public function run(): void
    {
        BudgetPreset::insert([
            ['name' => 'Populer 50/30/20', 'food_pct' => 50, 'operational_pct' => 30, 'healing_pct' => 20, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Seimbang 40/40/20', 'food_pct' => 40, 'operational_pct' => 40, 'healing_pct' => 20, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Hemat Ketat 60/25/15', 'food_pct' => 60, 'operational_pct' => 25, 'healing_pct' => 15, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}