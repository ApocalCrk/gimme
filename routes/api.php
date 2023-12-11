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
        Route::get('findDatabyId/{id}', 'App\Http\Controllers\UserController@findDatabyId');
        Route::put('updatePhoto/{id}', 'App\Http\Controllers\UserController@updatePhoto');
        Route::get('get7DaysHistory/{uid}', 'App\Http\Controllers\HistoryController@get7DaysHistory');
        Route::get('getAverage7DaysWorkout/{uid}', 'App\Http\Controllers\HistoryController@getAverage7DaysWorkout');
        Route::get('getAllHistory/{uid}', 'App\Http\Controllers\HistoryController@getAllHistory');
        Route::get('getHistoryByDate/{uid}/{date}', 'App\Http\Controllers\HistoryController@getHistoryByDate');
        Route::get('getHistoryBySearch/{uid}/{search}', 'App\Http\Controllers\HistoryController@getHistoryBySearch');
        Route::get('getAllTransaction/{uid}', 'App\Http\Controllers\TransactionController@getAllTransaction');
        Route::get('getTransactionBySearch/{uid}/{search}', 'App\Http\Controllers\TransactionController@getTransactionBySearch');
        Route::get('getTransactionByDate/{uid}/{date}', 'App\Http\Controllers\TransactionController@getTransactionByDate');
        Route::get('countTask/{uid}', 'App\Http\Controllers\TodoController@countTask');
        Route::get('getAllTaskbyDate/{uid}/{date}', 'App\Http\Controllers\TodoController@getAllTaskbyDate');
        Route::post('createTask', 'App\Http\Controllers\TodoController@createTask');
        Route::put('updateTask/{id}', 'App\Http\Controllers\TodoController@updateTask');
        Route::delete('deleteTask/{id}', 'App\Http\Controllers\TodoController@deleteTask');
    }); 
    Route::prefix('gym')->group(function(){
        Route::get('getMapsDetailGym/{lat}/{long}', 'App\Http\Controllers\GymController@getMapsDetailGym');
        Route::get('getDetailGymId/{id}', 'App\Http\Controllers\GymController@getDetailGymId');
        Route::get('getNearbyGym/{lat}/{long}', 'App\Http\Controllers\GymController@getNearbyGym');
        Route::get('getTopGym/{lat}/{long}', 'App\Http\Controllers\GymController@getTopGyms');
        Route::get('getTopReviewsGym/{lat}/{long}', 'App\Http\Controllers\GymController@getTopReviewsGyms');
        Route::get('searchGymByNearby/{lat}/{long}/{search}', 'App\Http\Controllers\GymController@searchGymByNearby');
        Route::get('countMembership/{id}', 'App\Http\Controllers\GymController@countMembership');
        Route::prefix('review')->group(function(){
            Route::post('sendGymReview', 'App\Http\Controllers\gymreviewController@sendGymReview');
            Route::post('uploadImage', 'App\Http\Controllers\gymreviewController@uploadImage');
            Route::get('getGymReviews/{id}', 'App\Http\Controllers\gymreviewController@getGymReviews');
            Route::get('getReview/{id}/{uid}', 'App\Http\Controllers\gymreviewController@getReview');
            Route::put('updateReview', 'App\Http\Controllers\gymreviewController@updateReview');
            Route::delete('deleteReview', 'App\Http\Controllers\gymreviewController@deleteReview');
        });
    });
    Route::prefix('workout')->group(function(){
        Route::post('create', 'App\Http\Controllers\ExcerciseTypeController@create');
        Route::get('getDataExerciseById/{id}', 'App\Http\Controllers\ExcerciseTypeController@getDataExerciseById');
        Route::get('getAllDataWorkout', 'App\Http\Controllers\ExcerciseTypeController@getAllDataWorkout');
    });
    Route::prefix('transaction')->group(function(){
        Route::post('sendTransaction', 'App\Http\Controllers\TransactionController@sendTransaction');
        Route::get('findMembershipCheck/{id_gym}/{uid}', 'App\Http\Controllers\TransactionController@findMembershipCheck');
        Route::get('getAllMembership/{uid}', 'App\Http\Controllers\TransactionController@getAllMembership');
        Route::post('generateQrCode', 'App\Http\Controllers\TransactionController@generateQrCode');
        Route::delete('checkoutMembership', 'App\Http\Controllers\TransactionController@checkoutMembership');
        Route::delete('cancelMembership', 'App\Http\Controllers\TransactionController@cancelMembership');
    });
    Route::prefix('history_workout')->group(function(){
        Route::post('sendDataExercises', 'App\Http\Controllers\HistoryExerciseController@sendDataExercises');
    });
});