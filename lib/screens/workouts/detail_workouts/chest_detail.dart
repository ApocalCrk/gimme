import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:gimme/constants.dart';

class ChestDetail extends StatefulWidget {
  const ChestDetail({super.key});

  @override
  State<ChestDetail> createState() => _ChestDetailState();
}

class Notify {
  static Future<bool> instantNotify() async {
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return awesomeNotifications.createNotification(
      content: NotificationContent(
          id: Random().nextInt(100),
          channelKey: 'instant_notification',
          title: "Gimme Notification",
          body: "Thanks for using gimme, keep ur spirit to go FIT !!!"),
    );
  }
}

class _ChestDetailState extends State<ChestDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 270,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/workouts_images/chest_detail_images/chest_detail.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: InkWell(
                  child: Icon(Icons.arrow_back_rounded,
                      color: Colors.white, size: 40),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(13.0),
                child: Text(
                  "Chest Workout",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "A chest workout, often referred to as a chest training routine or chest exercise regimen," +
                            "is a structured series of physical exercises designed to target and strengthen the muscles in the chest area." +
                            "The primary muscle group worked during a chest workout is the pectoralis major, which is the large muscle located" +
                            "in the front of the upper body. A well-developed chest not only contributes to an aesthetic appearance but also plays" +
                            "a crucial role in upper body strength and functionality.",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50.0, left: 15.0),
                  ),
                  Text(
                    "Excercise (5)",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Detail_Exercise(
                      image:
                          "assets/images/workouts_images/chest_detail_images/dumbbel_press.png",
                      exercise_name: "Dumbell Press",
                      time_exercise: 15),
                  Detail_Exercise(
                      image:
                          "assets/images/workouts_images/chest_detail_images/barbel_press.png",
                      exercise_name: "Barbell Press",
                      time_exercise: 20),
                  Detail_Exercise(
                      image:
                          "assets/images/workouts_images/chest_detail_images/landmine_press.png",
                      exercise_name: "Landmine Pres",
                      time_exercise: 22),
                  Detail_Exercise(
                      image:
                          "assets/images/workouts_images/chest_detail_images/plate_pressout.png",
                      exercise_name: "Plate Pressout",
                      time_exercise: 17),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Detail_Exercise extends StatefulWidget {
  final String image, exercise_name;
  int time_exercise;
  Detail_Exercise(
      {super.key,
      required this.image,
      required this.exercise_name,
      required this.time_exercise});

  @override
  State<Detail_Exercise> createState() => _Detail_ExerciseState();
}

@override
class _Detail_ExerciseState extends State<Detail_Exercise> {
  Timer? timer;
  int timer_start = 10;
  bool isStart = true;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (timer_start > 0) {
        setState(() {
          isStart = false;
          timer_start--;
          print("waktu tunggu :" + timer_start.toString());
        });
      } else {
        setState(() {
          isStart = true;
          timer_start = 10;
          Notify.instantNotify();
          stopTimer();
        });
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.image), fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: isStart
                                  ? MaterialStatePropertyAll(primaryColor)
                                  : MaterialStatePropertyAll(errorColor)),
                          onPressed: () {
                            setState(() {
                              isStart = !isStart;
                              startTimer();
                            });
                          },
                          child: isStart
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
              width: 400,
              height: 100,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 19.0),
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
