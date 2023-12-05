import 'package:flutter/material.dart';
import 'package:gimme/screens/workout/controller/workout_controller.dart';
import 'package:gimme/screens/workout/detail_workout.dart';
import 'package:gimme/screens/workout/model/workout_model.dart';
import 'package:gimme/screens/workout/workout_components/workout_item.dart';

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
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Workouts",
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 25,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder<List<Workout>>(
          future: WorkoutController().getAllDataWorkout(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
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

// class WorkoutItem extends StatelessWidget {
//   final int id_workout;
//   final String workout_name, workout_type;
//   final String image;
//   WorkoutItem(
//       {super.key,
//       required this.id_workout,
//       required this.image,
//       required this.workout_name,
//       required this.workout_type});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 image == ''
//                     ? Shimmer.fromColors(
//                         baseColor: Colors.grey[300]!,
//                         highlightColor: Colors.grey[100]!,
//                         child: Container(
//                           height: 120,
//                           width: 380,
//                           color: Colors.white,
//                         ),
//                       )
//                     : Image.network(
//                         width: MediaQuery.of(context).size.width,
//                         height: 120,
//                         image),
//                 Container(
//                   width: 380,
//                   height: 120,
//                   padding: const EdgeInsets.only(left: 30),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           workout_name,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontFamily: "Montserrat",
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           workout_type,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontFamily: "Montserrat"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
