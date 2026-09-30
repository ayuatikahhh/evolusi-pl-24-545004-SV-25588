<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\PresetController;

Route::get('/presets', [PresetController::class, 'index']);