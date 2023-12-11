<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Todo;

class TodoController extends Controller
{
    public function getAllTaskbyDate(Request $request){
        $todo = Todo::where('uid', $request->uid)->whereDate('date', $request->date)->get();
        if($todo){
            return response()->json(['status' => 'success', 'data' => $todo], 200);
        }else{
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function createTask(Request $request){
        $todo = Todo::create([
            'uid' => $request->uid,
            'title' => $request->title,
            'calories' => $request->calories,
            'duration' => $request->duration,
            'date' => $request->date
        ]);
        if($todo){
            return response()->json(['status' => 'success', 'data' => $todo], 200);
        }else{
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function updateTask(Request $request){
        $todo = Todo::where('id', $request->id)->first();
        if($todo){
            $todo->title = $request->title;
            $todo->calories = $request->calories;
            $todo->duration = $request->duration;
            $todo->date = $request->date;
            $todo->save();
            return response()->json(['status' => 'success', 'data' => $todo], 200);
        }else{
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function deleteTask(Request $request){
        $todo = Todo::where('id', $request->id)->first();
        if($todo){
            $todo->delete();
            return response()->json(['status' => 'success'], 200);
        }else{
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function countTask(Request $request){
        $todo = Todo::where('uid', $request->uid)->count();
        return response()->json($todo, 200);
    }
}
