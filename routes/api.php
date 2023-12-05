<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::prefix('v1')->group(function() {
    Route::prefix('auth')->group(function(){
        Route::post('login', 'App\Http\Controllers\UserController@login');
        Route::post('register', 'App\Http\Controllers\UserController@register');
    });
    Route::prefix('user')->group(function(){
        Route::put('updateUser', 'App\Http\Controllers\UserController@updateUser');
        Route::put('updatePhoto/{username}', 'App\Http\Controllers\UserController@updatePhoto');
    });
    Route::prefix('gym')->group(function(){
        Route::get('getMapsDetailGym/{lat}/{long}', 'App\Http\Controllers\GymController@getMapsDetailGym');
        Route::get('getDetailGymId/{id}', 'App\Http\Controllers\GymController@getDetailGymId');
        Route::prefix('review')->group(function(){
            Route::post('sendGymReview', 'App\Http\Controllers\gymreviewController@sendGymReview');
            Route::post('uploadImage', 'App\Http\Controllers\gymreviewController@uploadImage');
            Route::get('getGymReviews/{id}', 'App\Http\Controllers\gymreviewController@getGymReviews');
            Route::get('getReview/{id}/{uid}', 'App\Http\Controllers\gymreviewController@getReview');
            Route::put('updateReview', 'App\Http\Controllers\gymreviewController@updateReview');
            Route::delete('deleteReview', 'App\Http\Controllers\gymreviewController@deleteReview');
        });
    });
    Route::prefix('transaction')->group(function(){
        Route::post('sendTransaction', 'App\Http\Controllers\TransactionController@sendTransaction');
        Route::get('findMembershipCheck/{id_gym}/{uid}', 'App\Http\Controllers\TransactionController@findMembershipCheck');
    });
});