// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gimme/screens/workout/controller/workout_controller.dart';
import 'package:gimme/screens/workout/detail_workout.dart';
import 'package:gimme/screens/workout/model/workout_model.dart';
import 'package:gimme/screens/workout/workout_components/workout_item.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  _WorkoutsScreenState createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  bool showPerformance = false;

  onSettingCallback() {
    setState(() {
      showPerformance = !showPerformance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Workouts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: FutureBuilder<List<Workout>>(
          future: WorkoutController().getAllDataWorkout(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    int total_time = 0;
                    int total_exercise = snapshot.data![index].exercises.length;
                    List dataExercise = [];
                    snapshot.data![index].exercises.forEach((key, value) {
                      total_time = total_time + int.parse(value['duration']);
                      dataExercise.add(value);
                    });
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WorkoutDetail(
                              workout_name: snapshot.data![index].workout_name,
                              description: snapshot.data![index].description,
                              id_workout: snapshot.data![index].id_workout,
                              image: snapshot.data![index].detail_image,
                              total_time: total_time,
                              total_exercise: total_exercise,
                              duration: dataExercise[index]['duration'],
                              kalori: dataExercise[index]['kalori'],
                              data: dataExercise,
                            ),
                          ),
                        );
                      },
                      child: WorkoutItem(
                        image: snapshot.data![index].image,
                        workout_name: snapshot.data![index].workout_name,
                        workout_type: snapshot.data![index].category,
                        id_workout: snapshot.data![index].id_workout,
                      ),
                    );
                  });
            }
          }),
    );
  }
}