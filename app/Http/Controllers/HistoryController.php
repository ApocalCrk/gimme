<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\HistoryExercise;
use Illuminate\Support\Facades\DB;

class HistoryController extends Controller
{
    public function get7DaysHistory(Request $request) {
        $history = HistoryExercise::where('uid', $request->uid)
            ->whereBetween('created_at', [now()->subDays(7), now()])
            ->get()
            ->map(function ($item) {
                $item->exercise_day = $item->created_at->format('Y-m-d');
                return $item;
            });
            
        $history7days = [];
        for ($i = 0; $i < 7; $i++) {
            $history7days[] = [
                'exercise_day' => now()->subDays($i)->format('Y-m-d'),
                'calories' => $history->where('exercise_day', now()->subDays($i)->format('Y-m-d'))->sum('calories'),
                'duration' => $history->where('exercise_day', now()->subDays($i)->format('Y-m-d'))->sum('duration')
            ];
        }
    
        return response()->json(['status' => 'success', 'data' => $history7days], 200);
    }

    public function getAverage7DaysWorkout(Request $request) {
        $history = HistoryExercise::where('uid', $request->uid)
            ->whereBetween('created_at', [now()->subDays(7), now()])
            ->get()
            ->groupBy(function ($item) {
                return $item->created_at->format('Y-m-d');
            })
            ->map(function ($item) {
                return $item->sum('duration');
            })
            ->avg();
        if ($history == null) {
            $history = 0;
        }
    
        return response()->json(['status' => 'success', 'data' => $history], 200);
    }

    public function getAllHistory(Request $request) {
        $history = HistoryExercise::with(['exerciseType' => function ($query) use ($request) {
            $query->select(['id_exercise_type', 'workout_name', 'category', 'created_at', 'updated_at']);
            }])
            ->where('uid', $request->uid)
            ->orderBy('created_at', 'desc')
            ->paginate(10);
        return response()->json($history, 200);
    }

    public function getHistoryByDate(Request $request) {
        $history = HistoryExercise::with(['exerciseType' => function ($query) use ($request) {
            $query->select(['id_exercise_type', 'workout_name', 'category', 'created_at', 'updated_at']);
            }])
            ->where('uid', $request->uid)->whereDate('created_at', $request->date)
            ->orderBy('created_at', 'desc')
            ->get();
        return response()->json($history, 200);
    }

    public function getHistoryBySearch(Request $request) {
        $history = HistoryExercise::with(['exerciseType' => function ($query) use ($request) {
                $query->select(['id_exercise_type', 'workout_name', 'category', 'created_at', 'updated_at']);
            }])
            ->where('uid', $request->uid)
            ->whereHas('exerciseType', function ($query) use ($request) {
                $query->where('workout_name', 'like', '%' . $request->search . '%');
            })
            ->orderBy('created_at', 'desc')
            ->get();
        return response()->json($history, 200);
    }
    
}
