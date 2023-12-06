<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\HistoryExercise;

class HistoryExerciseController extends Controller
{
    public function sendDataExercises(Request $request){
        $data = $request->all();
        $historyData = HistoryExercise::where('uid', $request->uid)->where('id_exercise_type', $request->id_exercise_type)->first();
        if($historyData){
            HistoryExercise::create($data);
            return response()->json(['status' => 'success', 'data' => $data],200);
        }else{
            return response()->json(['status' => 'fail', 'data' => null],400);
        }
    }
}