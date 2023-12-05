import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:gimme/screens/workout/workout_components/detail_exercise.dart';
import 'package:gimme/screens/workout/workout_components/slide_up_exercise.dart';

class WorkoutDetail extends StatefulWidget {
  final int id_workout, total_time, total_exercise;
  final String image, description, workout_name, kalori, duration;
  final List data;
  const WorkoutDetail(
      {super.key,
      required this.total_exercise,
      required this.image,
      required this.description,
      required this.id_workout,
      required this.workout_name,
      required this.total_time,
      required this.data,
      required this.duration,
      required this.kalori});

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
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

class _WorkoutDetailState extends State<WorkoutDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.image), fit: BoxFit.cover)),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: InkWell(
                  child: Icon(Icons.arrow_back_rounded,
                      color: Colors.white, size: 40),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.33,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(163, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.total_time.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat",
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Text(
                            'minutes',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  widget.workout_name,
                  style: const TextStyle(
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
                        widget.description,
                        style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
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
                    "Excercise (${widget.total_exercise})",
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
            child: Container(
              child: ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    var data = widget.data[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return modalSlideUp(data: data);
                              });
                        },
                        child: Detail_Exercise(
                            image: data['image'],
                            exercise_name: data['name'],
                            time_exercise: int.parse(data['duration']),
                            kalori: data['kalori'],
                            duration: data['duration'],
                            id_workout: widget.id_workout,
                            toogleStart: true),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

// class _modalSlideUp extends StatelessWidget {
//   const _modalSlideUp({
//     super.key,
//     required this.data,
//   });

//   final data;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.70,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25.0),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 15.0),
//                 child: Container(
//                   width: 30.0,
//                   height: 8.0,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(25.0),
//                       color: Colors.grey.shade400),
//                 ),
//               ),
//             ],
//           ),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 35.0, left: 15.0, bottom: 10.0),
//                 child: Text(
//                   'Description',
//                   style: TextStyle(
//                     fontFamily: "Montserrat",
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 child: Text(
//                   data['description_excercise'],
//                   textAlign: TextAlign.justify,
//                   style: TextStyle(
//                     fontFamily: "Montserrat",
//                     fontSize: 13,
//                     color: Colors.grey.shade700,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ))
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 15.0, right: 15.0, bottom: 40.0, top: 30.0),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 1.3,
//                     decoration: BoxDecoration(color: Colors.grey.shade600),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 25.0),
//                     child: Text('Stand',
//                         style: TextStyle(
//                           fontFamily: "Montserrat",
//                           fontSize: 15,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         )),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 0),
//                     child: Text('Burn',
//                         style: TextStyle(
//                           fontFamily: "Montserrat",
//                           fontSize: 15,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         )),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 25.0),
//                     child: Text('Sets',
//                         style: TextStyle(
//                           fontFamily: "Montserrat",
//                           fontSize: 15,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         )),
//                   )
//                 ],
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15.0),
//                     child: Text('${data['duration']} minutes',
//                         style: TextStyle(
//                           fontFamily: "Montserrat",
//                           fontSize: 14,
//                           color: Colors.grey.shade500,
//                           fontWeight: FontWeight.w700,
//                         )),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 20.0),
//                     child: Text('${data['kalori']} cals',
//                         style: TextStyle(
//                           fontFamily: "Montserrat",
//                           fontSize: 14,
//                           color: Colors.grey.shade500,
//                           fontWeight: FontWeight.w700,
//                         )),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 40.0),
//                     child: Text('${data['set']}',
//                         style: TextStyle(
//                           fontFamily: "Montserrat",
//                           fontSize: 14,
//                           color: Colors.grey.shade500,
//                           fontWeight: FontWeight.w700,
//                         )),
//                   )
//                 ],
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 15.0, right: 15.0, bottom: 20.0, top: 40.0),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 1.3,
//                     decoration: BoxDecoration(color: Colors.grey.shade600),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Reps",
//                 style: TextStyle(
//                   fontFamily: "Montserrat",
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 15.0, vertical: 60.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 for (int i = 0; i < int.parse(data['set']); i++)
//                   Column(
//                     children: [
//                       Container(
//                         width: 20.0,
//                         height: 5.0,
//                         decoration: const BoxDecoration(
//                           color: Colors.black,
//                         ),
//                       )
//                     ],
//                   )
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.width * 0.13,
//                         child: TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Start",
//                             style: TextStyle(
//                                 fontFamily: "Montserrat",
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                           style: ButtonStyle(
//                               backgroundColor:
//                                   MaterialStatePropertyAll(primaryColor)),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Detail_Exercise extends StatefulWidget {
//   final String image, exercise_name, kalori, duration;
//   final int id_workout;
//   int time_exercise;
//   Detail_Exercise(
//       {super.key,
//       required this.image,
//       required this.exercise_name,
//       required this.time_exercise,
//       required this.duration,
//       required this.kalori,
//       required this.id_workout});

//   @override
//   State<Detail_Exercise> createState() => _Detail_ExerciseState();
// }

// @override
// class _Detail_ExerciseState extends State<Detail_Exercise>
//     with WidgetsBindingObserver {
//   Timer? _timer;
//   bool isStart = true;

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       setState(() {
//         widget.id_workout;
//         widget.kalori;
//         widget.duration;
//         dataUser['uid'];
//         startTimer();
//       });
//     } else if (state == AppLifecycleState.paused) {
//       _timer!.cancel();
//     }
//   }

//   @override
//   void dispose() {
//     _timer!.cancel();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   void startTimer() {
//     // int timer_start = widget.time_exercise * 60;
//     int timer_start = 5;
//     _timer = Timer.periodic(Duration(seconds: 1), (_) {
//       if (timer_start > 0) {
//         timer_start--;
//         print("Remaining Time: $timer_start seconds");
//       } else {
//         setState(() {
//           isStart = true;
//           // timer_start = widget.time_exercise * 60;
//           timer_start = 5;
//           WorkoutController().sendDataToApi(
//               int.parse(dataUser['uid'].toString()),
//               widget.id_workout,
//               widget.duration,
//               widget.kalori);
//           Notify.instantNotify();
//           stopTimer();
//         });
//       }
//     });
//   }

//   void stopTimer() {
//     _timer!.cancel();
//   }

//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Stack(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.width * 0.23,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: NetworkImage(widget.image), fit: BoxFit.cover),
//               ),
//             ),
//             Column(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.width * 0.23,
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: TextButton(
//                           style: ButtonStyle(
//                               backgroundColor: isStart
//                                   ? MaterialStatePropertyAll(primaryColor)
//                                   : MaterialStatePropertyAll(errorColor)),
//                           onPressed: () {
//                             setState(() {
//                               isStart = !isStart;
//                               if (isStart == true) {
//                                 stopTimer();
//                               } else {
//                                 startTimer();
//                               }
//                             });
//                           },
//                           child: isStart
//                               ? Text(
//                                   "Start",
//                                   style: TextStyle(
//                                       fontFamily: "Montserrat",
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 )
//                               : Text(
//                                   "On Going",
//                                   style: TextStyle(
//                                       fontFamily: "Montserrat",
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.width * 0.23,
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Text(
//                         widget.exercise_name,
//                         style: TextStyle(
//                             fontFamily: "Montserrat",
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Text(
//                         "" + widget.time_exercise.toString() + " Minutes",
//                         style: TextStyle(
//                             fontFamily: "Montserrat",
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
