class History_Workout {
  final int id_history, id_workout, uid;
  final String calories, duration;

  History_Workout(
      {required this.calories,
      required this.duration,
      required this.id_history,
      required this.id_workout,
      required this.uid});

  factory History_Workout.fromJson(Map<String, dynamic> json) {
    return History_Workout(
        calories: json['calories'],
        duration: json['duration'],
        id_history: json['id_history_exercise'],
        id_workout: json['id_exercise_type'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_history_exercise': id_history,
      'id_exrcise_type': id_workout,
      'uid': uid,
      'calories': calories,
      'duration': duration,
    };
  }
}
