<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Gym;
use Illuminate\Support\Facades\Storage;

class GymController extends Controller
{
    public function getMapsDetailGym(Request $request){
        $lat = $request->lat;
        $long = $request->long;
        $gym = Gym::with('gymreviews')->where('location', $lat.', '.$long)->first();
        if($gym){
            $imagesReview = [];
            foreach($gym->gymreviews as $value){
                $images = json_decode($value->images, true);
                foreach($images as $value){
                    $imagesReview[] = asset('storage/'.$value);
                }
            } 
            shuffle($imagesReview);
            $imagesReview = array_slice($imagesReview, 0, 3);
            $gym->pickImages = $imagesReview;
            $gym->image = asset('storage/'.$gym->image);
            return response()->json(['status' => 'success', 'data' => $gym],200);
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }

    public function getDetailGymId($id) {
        $gym = Gym::with('gymreviews')->where('id_gym', $id)->first();
        if($gym){
            $gym->image = asset('storage/'.$gym->image);
            return response()->json(['status' => 'success', 'data' => $gym],200);
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }
}
