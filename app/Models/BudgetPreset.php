<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BudgetPreset extends Model
{
    protected $table = 'budget_presets';

    protected $fillable = ['name', 'food_pct', 'operational_pct', 'healing_pct'];
}