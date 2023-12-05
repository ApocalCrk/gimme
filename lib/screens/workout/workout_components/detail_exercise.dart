import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/workout/controller/workout_controller.dart';
import 'package:gimme/screens/workout/detail_workout.dart';

class Detail_Exercise extends StatefulWidget {
  final String image, exercise_name, kalori, duration;
  final int id_workout;
  final bool toogleStart;
  int time_exercise;
  Detail_Exercise(
      {super.key,
      required this.toogleStart,
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
class _Detail_ExerciseState extends State<Detail_Exercise>
    with WidgetsBindingObserver {
  Timer? _timer;
  bool? isStart;

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     startTimer();
  //     isStart = isStart;
  //   } else if (state == AppLifecycleState.paused) {
  //     _timer!.cancel();
  //   }
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  void startTimer() {
    // int timer_start = widget.time_exercise * 60;
    int timer_start = 5;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (timer_start > 0) {
        if (this.mounted) {
          setState(() {
            print("Remaining Time: $timer_start seconds");
            timer_start--;
            isStart = false;
            print(isStart);
          });
        } else {
          print("Remaining Time: $timer_start seconds");
          timer_start--;
          isStart = false;
          print('kontol ${isStart}');
        }
      } else {
        if (this.mounted) {
          setState(() {
            isStart = true;
            // timer_start = widget.time_exercise * 60;
            timer_start = 5;
            WorkoutController().sendDataToApi(
                int.parse(dataUser['uid'].toString()),
                widget.id_workout,
                widget.kalori,
                widget.duration);
            Notify.instantNotify();
            stopTimer();
            print(isStart);
          });
        } else {
          print('kinitl ${isStart}');
          isStart = true;
          // timer_start = widget.time_exercise * 60;
          timer_start = 5;
          WorkoutController().sendDataToApi(
              int.parse(dataUser['uid'].toString()),
              widget.id_workout,
              widget.kalori,
              widget.duration);
          Notify.instantNotify();
          stopTimer();
        }
      }
    });
  }

  void stopTimer() {
    _timer!.cancel();
  }

  void initState() {
    super.initState();
    if (isStart == null) {
      isStart = widget.toogleStart;
    } else {
      isStart = isStart;
    }
  }

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
                    image: NetworkImage(widget.image), fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                Container(
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
                              backgroundColor: isStart!
                                  ? MaterialStatePropertyAll(primaryColor)
                                  : MaterialStatePropertyAll(errorColor)),
                          onPressed: () {
                            setState(() {
                              isStart = !isStart!;
                              if (isStart == true) {
                                stopTimer();
                              } else {
                                startTimer();
                              }
                            });
                          },
                          child: isStart!
                              ? Text(
                                  "Start",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              : Text(
                                  "On Going",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.23,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        widget.exercise_name,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "" + widget.time_exercise.toString() + " Minutes",
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
