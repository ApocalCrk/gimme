// ignore_for_file: non_constant_identifier_names, file_names
class ExerciseData {
  final int duration;
  final int calories;
  final DateTime exercise_day;

  ExerciseData({
    required this.duration,
    required this.calories,
    required this.exercise_day,
  });

  factory ExerciseData.fromJson(Map<String, dynamic> json) {
    return ExerciseData(
      duration: json['duration'],
      calories: json['calories'],
      exercise_day: DateTime.parse(json['exercise_day']),
    );
  }

  Map<String, dynamic> toJson() => {
    'duration': duration,
    'calories': calories,
    'exercise_day': exercise_day,
  };
}