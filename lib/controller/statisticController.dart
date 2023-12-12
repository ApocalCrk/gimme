import 'dart:convert';

import 'package:gimme/constants.dart';
import 'package:gimme/data/History.dart';
import 'package:http/http.dart';

class StatisticController {
  Future<List<ExerciseData>> getExerciseData(int uid) async {
    var response = await get(Uri.http(url, "$endpoint/user/get7DaysHistory/$uid"));
    var data = json.decode(response.body)['data'];
    List<ExerciseData> exerciseData = [];
    for (var i in data) {
      exerciseData.add(ExerciseData.fromJson(i));
    }
    return exerciseData;
  }

  Future<String> getAverage7DaysWorkout(int uid) async {
    var response = await get(Uri.http(url, "$endpoint/user/getAverage7DaysWorkout/$uid"));
    return json.decode(response.body)['data'].toString();
  }
}