class Workout {
  final int id_workout;
  final String description, image, workout_name, category, detail_image;
  final Map<String, dynamic> exercises;

  Workout({
    required this.id_workout,
    required this.description,
    required this.image,
    required this.detail_image,
    required this.workout_name,
    required this.category,
    required this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id_workout: json['id_exercise_type'],
      description: json['description'],
      image: json['image'],
      detail_image: json['detail_image'],
      workout_name: json['workout_name'],
      category: json['category'],
      exercises: json['exercises'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_exercise_type': id_workout,
      'description': description,
      'image': image,
      'detail_image': detail_image,
      'workout_name': workout_name,
      'category': category,
      'exercises': exercises,
    };
  }
}

class Exercise {
  final int id;
  final String description_exercise, name, duration, image, kalori, reps, set;

  Exercise({
    required this.description_exercise,
    required this.duration,
    required this.id,
    required this.image,
    required this.kalori,
    required this.name,
    required this.reps,
    required this.set,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        description_exercise: json['description_exercise'],
        duration: json['duration'],
        id: json['id'],
        image: json['image'],
        kalori: json['kalori'],
        name: json['name'],
        reps: json['reps'],
        set: json['set']);
  }

  Map<String, dynamic> toJson() {
    return {
      'description_exercise': description_exercise,
      'duration': duration,
      'id': id,
      'image': image,
      'kalori': kalori,
      'name': name,
      'reps': reps,
      'set': set,
    };
  }
}
