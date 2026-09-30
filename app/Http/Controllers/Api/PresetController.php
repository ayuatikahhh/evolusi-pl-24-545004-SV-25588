<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\BudgetPreset;
use Illuminate\Http\JsonResponse;

class PresetController extends Controller
{
    public function index(): JsonResponse
    {
        return response()->json([
            'status' => 'success',
            'data' => BudgetPreset::all()
        ]);
    }
}