// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, prefer_const_constructors, unnecessary_this, avoid_print
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';

class Detail_Exercise extends StatefulWidget {
  final String image, exercise_name, kalori, duration;
  final int id_workout;
  int time_exercise;
  Detail_Exercise(
      {super.key,
      required this.image,
      required this.exercise_name,
      required this.time_exercise,
      required this.duration,
      required this.kalori,
      required this.id_workout});

  @override
  State<Detail_Exercise> createState() => _Detail_ExerciseState();
}

@override
class _Detail_ExerciseState extends State<Detail_Exercise> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.23,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExtendedImage.network(widget.image).image,
                    fit: BoxFit.cover
                )
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.23,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: tempDataPlan.isEmpty ?
                                  MaterialStatePropertyAll(primaryColor)
                                  : tempDataPlan['exercise_name'] == widget.exercise_name
                                      ? MaterialStatePropertyAll(errorColor)
                                      : MaterialStatePropertyAll(primaryColor)),
                          onPressed: () {
                            if(tempDataPlan.isEmpty){
                              tempDataPlan = {
                                "id_workout": widget.id_workout,
                                "exercise_name": widget.exercise_name,
                                "kalori": widget.kalori,
                                "duration": widget.duration,
                                "status": "start"
                              };
                              Navigator.pushNamed(context, '/dashboard', arguments: 1);
                            } else if(tempDataPlan['exercise_name'] != widget.exercise_name){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("You have an exercise plan"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }else{
                              setState(() {
                                tempDataPlan = {};
                              });
                            }
                          },
                          child: Text(
                            tempDataPlan.isEmpty ? 
                            "Start" : 
                            tempDataPlan['exercise_name'] == widget.exercise_name ? 
                            "On Going" : "Start",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.23,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3),
                      child: Text(
                        widget.exercise_name,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3),
                      child: Text(
                        "${widget.time_exercise} Minutes",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
