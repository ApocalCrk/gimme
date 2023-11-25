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
        $gym = Gym::where('location', $lat.', '.$long)->first();
        if($gym){
            $gym->image = base64_encode(Storage::disk('public')->get($gym->image));
            return response()->json(['status' => 'success', 'data' => $gym],200);
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }

    public function getDetailGymId($id) {
        $gym = Gym::where('id_gym', $id)->first();
        if($gym){
            $gym->image = base64_encode(Storage::disk('public')->get($gym->image));
            return response()->json(['status' => 'success', 'data' => $gym],200);
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }
}
