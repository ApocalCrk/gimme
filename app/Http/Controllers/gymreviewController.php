<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\GymReviews;
use Illuminate\Support\Facades\Storage;

class gymreviewController extends Controller
{
    public function getGymReviews(Request $request){
        $id = $request->id;
        $gymreviews = GymReviews::with('user')->where('id_gym', $id)->get();
        if($gymreviews){
            $gymreviews->map(function($item){
                if($item->images == null){
                    $item->images = [];
                    $item->user->profilepicture = asset('storage/'.$item->user->profilepicture);
                }else{
                    $images = json_decode($item->images, true);
                    $newimages = [];
                    foreach($images as $value){
                        $newimages[] = asset('storage/'.$value);
                    }
                    $item->images = $newimages;
                    $item->user->profilepicture = asset('storage/'.$item->user->profilepicture);
                }
                return $item;
            });
            return response()->json(['status' => 'success', 'data' => $gymreviews],200);
        }else{
            return response()->json(['status' => 'fail'],401);
        }
    }

    public function getReview(Request $request) {
        $id_gym = $request->id;
        $uid = $request->uid;
        $gymreview = GymReviews::where('id_gym', $id_gym)->where('uid', $uid)->first();
        if($gymreview){
            if($gymreview->images == null){
                $gymreview->images = [];
                $gymreview->user->profilepicture = asset('storage/'.$gymreview->user->profilepicture);
            }else{
                $images = json_decode($gymreview->images, true);
                $newimages = [];
                foreach($images as $value){
                    $newimages[] = asset('storage/'.$value);
                }
                $gymreview->images = $newimages;
                $gymreview->user->profilepicture = asset('storage/'.$gymreview->user->profilepicture);
            }
            return response()->json(['status' => 'success', 'data' => $gymreview],200);
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

    public function uploadImage(Request $request){
        $getTempReview = GymReviews::where('id_gym', $request->id_gym)->where('uid', $request->uid)->first();
        $paths = [];
        print_r($request->all());
        if ($request->hasFile('images')) {
            if($getTempReview->images != null){
                $images = json_decode($getTempReview->images, true);
                foreach($images as $image){
                    Storage::delete('public/'.$image);
                }
            }
            foreach($request->file('images') as $image){
                $path = Storage::putFile('public/gymReviews/'.$request->id_gym.'/'.$request->uid, $image);
                $paths[] = str_replace('public/', '', $path);
            }
            GymReviews::where('id_gym', $request->id_gym)->where('uid', $request->uid)->update(['images' => json_encode($paths)]);
            return response()->json(['path' => $paths], 200);
        }else{
            GymReviews::where('id_gym', $request->id_gym)->where('uid', $request->uid)->update(['images' => $paths]);
        }
        
        return response()->json(['message' => 'No image file found'], 400);
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
