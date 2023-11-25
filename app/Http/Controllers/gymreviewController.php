<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\GymReviews;

class gymreviewController extends Controller
{
    public function getGymReviews(Request $request){
        $id = $request->id;
        $gymreviews = GymReviews::with('user')->where('id_gym', $id)->get();
        if($gymreviews){
            return response()->json(['status' => 'success', 'data' => $gymreviews],200);
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }

    public function sendGymReview(Request $request){
        try{
            $data = $request->all();
            $gymreview = GymReviews::where('id_gym', $request->id_gym)->where('uid', $request->uid)->first();
            if($gymreview){
                return response()->json(['status' => 'review found'], 401);
            }
            GymReviews::create($data);
            return response()->json(['status' => 'success'], 200);
        }catch(\Exception $e){
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function deleteReview(Request $request){
        $id_gym = $request->id_gym;
        $uid = $request->uid;
        $gymreview = GymReviews::where('id_gym', $id_gym)->where('uid', $uid)->first();
        if($gymreview){
            $gymreview->delete();
            return response()->json(['status' => 'success'],200);
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }

    public function updateReview(Request $request){
        $id_gym = $request->id_gym;
        $uid = $request->uid;
        $gymreview = GymReviews::where('id_gym', $id_gym)->where('uid', $uid)->first();
        if($gymreview){
            $gymreview->rating = $request->rating;
            $gymreview->description = $request->description;
            $gymreview->save();
            return response()->json(['status' => 'success'],200);
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }
}
