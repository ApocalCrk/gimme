<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Gym;
use App\Models\Membership;

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

    public function getNearbyGym(Request $request){
        $lat = $request->lat;
        $long = $request->long;
        $radius = 5;
    
        $gym = Gym::with('gymreviews')->selectRaw("*, (6371 * acos(cos(radians($lat)) * cos(radians(SUBSTRING_INDEX(location, ',', 1))) * cos(radians(SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ' ', -1)) - radians($long)) + sin(radians($lat)) * sin(radians(SUBSTRING_INDEX(location, ',', 1))))) AS distance")
            ->having('distance', '<=', $radius)
            ->orderBy('distance')
            ->get();
    
        if($gym->isNotEmpty()){
            $gym->map(function($item){
                $item->image = asset('storage/'.$item->image);
                return $item;
            });
            return response()->json(['status' => 'success', 'data' => $gym], 200);
        } else {
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function getTopReviewsGyms(Request $request){
        $lat = $request->lat;
        $long = $request->long;
        $radius = 5;
    
        $gym = Gym::with('gymreviews')->selectRaw("*, (6371 * acos(cos(radians($lat)) * cos(radians(SUBSTRING_INDEX(location, ',', 1))) * cos(radians(SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ' ', -1)) - radians($long)) + sin(radians($lat)) * sin(radians(SUBSTRING_INDEX(location, ',', 1))))) AS distance")
            ->having('distance', '<=', $radius)
            ->orderBy('distance')
            ->get();
    
        if($gym->isNotEmpty()){
            $gym = $gym->sortByDesc(function($item){
                return $item->gymreviews->count();
            });
            $gym->map(function($item){
                $item->image = asset('storage/'.$item->image);
                return $item;
            });
            $gym = $gym->values()->all();
            return response()->json(['status' => 'success', 'data' => $gym], 200);
        } else {
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function getTopGyms(Request $request){
        $lat = $request->lat;
        $long = $request->long;
        $radius = 5;
    
        $gym = Gym::with('gymreviews')->selectRaw("*, (6371 * acos(cos(radians($lat)) * cos(radians(SUBSTRING_INDEX(location, ',', 1))) * cos(radians(SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ' ', -1)) - radians($long)) + sin(radians($lat)) * sin(radians(SUBSTRING_INDEX(location, ',', 1))))) AS distance")
            ->having('distance', '<=', $radius)
            ->orderBy('distance')
            ->get();
    
        if($gym->isNotEmpty()){
            $gym = $gym->sortByDesc(function($item){
                return $item->gymreviews->avg('rating');
            });
            $gym->map(function($item){
                $item->image = asset('storage/'.$item->image);
                return $item;
            });
            return response()->json(['status' => 'success', 'data' => $gym], 200);
        } else {
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function searchGymByNearby(Request $request){
        $lat = $request->lat;
        $long = $request->long;
        $radius = 5;
        $search = $request->search;
    
        $gym = Gym::with('gymreviews')->selectRaw("*, (6371 * acos(cos(radians($lat)) * cos(radians(SUBSTRING_INDEX(location, ',', 1))) * cos(radians(SUBSTRING_INDEX(SUBSTRING_INDEX(location, ',', 2), ' ', -1)) - radians($long)) + sin(radians($lat)) * sin(radians(SUBSTRING_INDEX(location, ',', 1))))) AS distance")
            ->having('distance', '<=', $radius)
            ->orderBy('distance')
            ->where('name', 'like', '%'.$search.'%')
            ->get();
    
        if($gym->isNotEmpty()){
            $gym->map(function($item){
                $item->image = asset('storage/'.$item->image);
                return $item;
            });
            return response()->json(['status' => 'success', 'data' => $gym], 200);
        } else {
            return response()->json(['status' => 'fail'], 401);
        }
    }

    public function countMembership($id){
        $membership = Membership::with('user')->where('id_gym', $id)->where('end_date', '>', now())->get();
        if($membership){
            $membership->map(function($item){
                $item->user->profilepicture = asset('storage/'.$item->user->profilepicture);
                return $item;
            });
            return response()->json(['status' => 'success', 'data' => $membership], 200);
        }
        return response()->json(['status' => 'fail'], 401);
    }
    
}
