<?php

namespace App\Http\Controllers;

use App\Models\ExerciseType;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class ExcerciseTypeController extends Controller
{
    public function create(){
        $data = [
                'description' => 'A chest workout is a set of exercises specifically designed to target and strengthen the muscles of the chest. The chest muscles, primarily the pectoralis major and minor, are crucial for various upper body movements, including pushing motions. A well-rounded chest workout typically includes exercises that focus on different areas of the chest, such as the upper, middle, and lower regions.',
                'workout_name'  => 'Chest Workout',
                'image' => 'chest_images/chest_workout.png',
                'detail_image' =>  'chest_images/chest_detail.png',
                'category' => 'Classic Workout',
                'exercises' => json_encode([
                    '1' => [
                        'id_exercise' => '1',
                        'description_excercise' => 'The dumbbell press is a popular strength training exercise that primarily targets the chest muscles (pectoralis major) but also engages the shoulders (anterior deltoids) and triceps. It can be performed on a flat bench, an incline bench, or a decline bench, depending on your specific goals and which part of the chest you want to emphasize. ', 
                        'name' => 'Dumbell Press',
                        'duration' => '15',
                        'image'=> 'chest_images/dummbell_press.png',
                        'kalori'=> '330',
                        'reps'=> '12',
                        'set'=> '5',
                    ],
                    '2' => [
                        'id_exercise' => '2',
                        'description_excercise' => 'The barbell press, often referred to as the barbell bench press, is a classic and fundamental strength training exercise that primarily targets the chest muscles (pectoralis major) but also engages the shoulders (anterior deltoids) and triceps.', 
                        'name' => 'Barbell Press',
                        'duration' => '15',
                        'image'=> 'chest_images/barbel_press.png',
                        'kalori'=> '355',
                        'reps'=> '12',
                        'set'=> '5',
                    ],
                    '3' => [
                        'id_exercise' => '3',
                        'description_excercise' => 'The landmine press is a versatile and effective strength training exercise that primarily targets the shoulders (deltoids) and engages the triceps, upper chest, and core muscles. Its typically performed using a landmine attachment, which is a barbell anchored to the ground or inserted into a landmine attachment platform', 
                        'name' => 'Landmine Press',
                        'duration' => '20',
                        'image'=> 'chest_images/landmine.png',
                        'kalori'=> '370',
                        'reps'=> '12',
                        'set'=> '5',
                    ],
                    '4' => [
                        'id_exercise' => '4',
                        'description_excercise' => 'The landmine press is a versatile and effective strength training exercise that primarily targets the shoulders (deltoids) and engages the triceps, upper chest, and core muscles. Its typically performed using a landmine attachment, which is a barbell anchored to the ground or inserted into a landmine attachment platform', 
                        'name' => 'Plate Pressout',
                        'duration' => '15',
                        'image'=> 'chest_images/plate_pressout.png',
                        'kalori'=> '340',
                        'reps'=> '12',
                        'set'=> '5',
                    ],
                ]),
        ];

        $excercise = ExerciseType::create($data);
        return response()->json(['status' => 'success', 'data' => $excercise],200);
    }

    public function getAllDataWorkout(){
        $dataWorkout = ExerciseType::all();
        $allExercises = [];
        if($dataWorkout){
            foreach($dataWorkout as $dataWorkouts){
                $exercises = json_decode($dataWorkouts->exercises, true);
                foreach($exercises as &$exercise){
                    $exercise['image'] = asset('storage/'.$exercise['image']);
                }
                $dataWorkouts->image = asset('storage/'.$dataWorkouts->image);
                $dataWorkouts->detail_image = asset('storage/'.$dataWorkouts->detail_image);
    
                $dataWorkouts->exercises = json_encode($exercises);
                
                $allExercises[] = $dataWorkouts;
            }
            return response()->json(['status' => 'success', 'data' => $allExercises], 200);
        } else {
            return response()->json(['status' => 'fail retrieve all data workouts'], 401);
        }
    }
}