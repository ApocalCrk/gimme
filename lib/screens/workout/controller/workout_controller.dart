// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'package:http/http.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/workout/model/workout_model.dart';

class WorkoutController {
  Future<List<Workout>> getAllDataWorkout() async {
    try {
      List<dynamic> list = [];
      var response =
          await get(Uri.http(url, '$endpoint/workout/getAllDataWorkout'))
              .then((value) {
        for (var item in jsonDecode(value.body)['data']) {
          item['exercises'] = jsonDecode(item['exercises']);
          list.add(item);
        }
      });
      var data = list.map((e) => Workout.fromJson(e)).toList();
      return data;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> sendDataToApi(
      int uid, int id_exercise, String calories, String duration) async {
    Map<String, dynamic> data = {
      'uid': uid.toString(),
      'id_exercise_type': id_exercise.toString(),
      'calories': calories,
      'duration': duration,
    };

    try {
      final response = await post(
          Uri.http(url, '$endpoint/history_workout/sendDataExercises'),
          body: data);
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
      } else {
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
