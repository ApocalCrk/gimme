import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/workouts/detail_workouts/chest_detail.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  _WorkoutsScreenState createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
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
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChestDetail()));
            },
            child: Workout(
                image: "assets/images/workouts_images/chest_workout.png",
                workout_name: "Chest Workout",
                workout_type: "Classic Workout"),
          ),
          Workout(
              image: "assets/images/workouts_images/arms_workout.png",
              workout_name: "Chest Workout",
              workout_type: "Classic Workout"),
          Workout(
              image: "assets/images/workouts_images/back_workout.png",
              workout_name: "Chest Workout",
              workout_type: "Classic Workout"),
          Workout(
              image: "assets/images/workouts_images/abs_workout.png",
              workout_name: "Chest Workout",
              workout_type: "Classic Workout"),
          Workout(
              image: "assets/images/workouts_images/legs_workout.png",
              workout_name: "Chest Workout",
              workout_type: "Classic Workout"),
        ],
      ),
    );
  }
}

class Workout extends StatelessWidget {
  final String image, workout_name, workout_type;
  Workout(
      {super.key,
      required this.image,
      required this.workout_name,
      required this.workout_type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.fill,
                  width: 380,
                  height: 120,
                ),
                Container(
                  width: 380,
                  height: 120,
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          workout_name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workout_type,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Montserrat"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
