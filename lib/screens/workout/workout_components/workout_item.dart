import 'package:flutter/material.dart';

class WorkoutItem extends StatelessWidget {
  final int id_workout;
  final String workout_name, workout_type;
  final String image;
  WorkoutItem(
      {super.key,
      required this.id_workout,
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
                Image.network(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    image),
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
