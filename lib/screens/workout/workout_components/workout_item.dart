// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables
import 'package:extended_image/extended_image.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: ExtendedImage.network(image).image,
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout_name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          workout_type,
                          style: const TextStyle(
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
