<?php

namespace App\Http\Controllers;

use App\Models\ExerciseType;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class ExcerciseTypeController extends Controller
{
    public function create(){
        // $data = [
        //         'description' => 'An abs (abdominal) workout focuses on strengthening the muscles in the core, including the rectus abdominis, obliques, and transverse abdominis. ',
        //         'workout_name'  => 'Abs Workout',
        //         'image' => 'abs_images/abs_workout.png',
        //         'detail_image' =>  'abs_images/abs_detail.png',
        //         'category' => 'Classic Workout',
        //         'exercises' => json_encode([
        //             '1' => [
        //                 'description_excercise' => 'Sit on the floor, lean back at a 45-degree angle, and lift your feet off the ground. Hold your hands together and twist your torso to touch the floor on each side.', 
        //                 'name' => 'Rusian Twist',
        //                 'duration' => '6',
        //                 'image'=> 'abs_images/rusian_twist.png',
        //                 'kalori'=> '125',
        //                 'reps'=> '20',
        //                 'set'=> '4',
        //             ],
        //             '2' => [
        //                 'description_excercise' => 'Start in a plank position and bring one knee towards your chest, then switch legs in a running motion. Keep your core engaged and maintain a steady pace.', 
        //                 'name' => 'Mountain Climbers',
        //                 'duration' => '7',
        //                 'image'=> 'abs_images/mountain_cliber.png',
        //                 'kalori'=> '200',
        //                 'reps'=> '30',
        //                 'set'=> '5',
        //             ],
        //             '3' => [
        //                 'description_excercise' => 'Lie on your back, legs extended. Lift your legs towards the ceiling, engaging your lower abs. Lower them back down without letting them touch the ground.', 
        //                 'name' => 'Leg Raises',
        //                 'duration' => '12',
        //                 'image'=> 'abs_images/leg_raises.png',
        //                 'kalori'=> '225',
        //                 'reps'=> '15',
        //                 'set'=> '5',
        //             ],
        //             '4' => [
        //                 'description_excercise' => 'Hang from a pull-up bar with straight arms. Lift your legs towards the ceiling, keeping them straight, and then lower them back down without swinging.', 
        //                 'name' => 'Hanging Leg Raises',
        //                 'duration' => '15',
        //                 'image'=> 'abs_images/hanging_legraises.png',
        //                 'kalori'=> '255',
        //                 'reps'=> '15',
        //                 'set'=> '5',
        //             ],
        //             '5' => [
        //                 'description_excercise' => 'Lie on your back with your legs extended. Lift your legs off the ground and perform small, rapid kicks while keeping your lower back pressed into the floor.', 
        //                 'name' => 'Flutter kicks',
        //                 'duration' => '10',
        //                 'image'=> 'abs_images/flutter_kick.png',
        //                 'kalori'=> '200',
        //                 'reps'=> '30',
        //                 'set'=> '5',
        //             ],
        //         ]),

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

    // public function getDataExerciseById(Request $request) {
    //         $id = $request->id;
    //         $dataWorkout = ExerciseType::where('id_exercise_type', $id)->first();

    //         if($dataWorkout){
    //             $exercises = json_decode($dataWorkout->exercises, true);
    //             foreach($exercises as &$data){
    //                 $data['image'] = asset('storage/'.$data['image']);
    //             }
    //             return response()->json(['status' => 'success', 'data' => $dataWorkout], 200);
    //         } else {
    //             return response()->json(['status' => 'fail'], 401);
    //         }
    // }

    // public function getAllDataWorkout(){
    //     $dataWorkout = ExerciseType::all();
        
    //     if($dataWorkout){
    //         foreach($dataWorkout as $dataWorkouts){
    //             $exercises = json_decode($dataWorkouts->exercises, true);
    //             foreach($exercises as $data){
    //                 $data['image'] = asset('storage/'.$data['image']);
    //             }
    //             $dataWorkouts->image = asset('storage/'.$dataWorkouts->image);
    //             $dataWorkouts->detail_image = asset('storage/'.$dataWorkouts->detail_image);
    //         }
    //         return response()->json(['status  retrieve all data workout' => 'success', 'data' => $dataWorkout, 'exercises' => $exercises],200);
    //     }else{
    //         return response()->json(['status' => 'fail retrieve all data workouts'],401);
    //     }
    // }

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