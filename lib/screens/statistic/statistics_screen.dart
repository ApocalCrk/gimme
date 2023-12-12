// ignore_for_file: library_private_types_in_public_api, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/controller/statisticController.dart';
import 'package:gimme/data/History.dart';
import 'package:gimme/controller/workout_controller.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const List<String> dropdownPlaceholder = <String>["Daily", "Monthly"];

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<ExerciseData> exerciseData = [];
  String averageWorkout = "";

  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    getAverageWorkout();
    getExerciseData();
    if(tempDataPlan.isNotEmpty) {
      if(tempDataPlan['status'] == 'start') {
        startTimer();
      } else {
        stopTimer();
      }
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Timer? _timer;
  int timerStart = 0;
  int elapsedTime = 0;

  

  void startTimer() {
    timerStart = int.parse(tempDataPlan['duration']) * 60;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (timerStart == 0) {
        setState(() {
          WorkoutController().sendDataToApi(
            int.parse(dataUser['uid'].toString()),
            tempDataPlan['id_workout'],
            tempDataPlan['kalori'],
            tempDataPlan['duration'],
          );
          getExerciseData();
          getAverageWorkout();
          tempDataPlan = {};
          Notify(
            title: '${tempDataPlan['exercise_name']} Finished',
            body: 'You have finished your workout',
            channelKey: 'gimme-channel',
          ).instantNotify();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Workout Finished',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: successColor,
            ),
          );
        });
        _timer!.cancel();
      } else if (tempDataPlan['status'] == 'start') {
        if(_isMounted){
          setState(() {
            timerStart--;
            elapsedTime++;
          });
        }
      }
    });
  }

  void stopTimer() {
    _timer!.cancel();
  }

  void pauseTimer() {
    setState(() {
      tempDataPlan['status'] = 'start';
    });
  }

  void resumeTimer() {
    setState(() {
      tempDataPlan['status'] = 'pause';
    });
  }

  String getDisplayedTime() {
    int minutes = elapsedTime ~/ 60;
    int seconds = elapsedTime % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }


  getExerciseData() async {
    var data = await StatisticController().getExerciseData(int.parse(dataUser['uid'].toString()));
    if (_isMounted) {
      setState(() {
        exerciseData = data;
      });
    }
  }

  getAverageWorkout() async {
    var data = await StatisticController().getAverage7DaysWorkout(int.parse(dataUser['uid'].toString()));
    if (_isMounted) {
      setState(() {
        if(data == '0') {
          averageWorkout = '0';
        } else {
          if(data.length >= 2) {
            averageWorkout = data.padLeft(2, '0');
          } else {
            averageWorkout = data;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Daily Statistics",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Average Workout',
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 15,
                      fontFamily: "Montserrat"
                    ),
                  ),
                  Text(
                    '$averageWorkout Min',
                    style: const TextStyle(
                      color: Color(0xff000000),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              exerciseData.isEmpty ? 
              SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('EEE'),
                intervalType: DateTimeIntervalType.days,
                labelAlignment: LabelAlignment.center
              ),
              primaryYAxis: NumericAxis(
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 0),
              ))
              :
              SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat('EEE'),
                  interval: 1,
                  intervalType: DateTimeIntervalType.days,
                ),
                primaryYAxis: NumericAxis(
                  axisLine: const AxisLine(width: 0), 
                ),
                trackballBehavior: TrackballBehavior(
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                  tooltipSettings: const InteractiveTooltip(
                    enable: true,
                    format: '🔥 point.y Calories',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat"
                    ),
                    canShowMarker: false,
                  ),
                  markerSettings: const TrackballMarkerSettings(
                    markerVisibility: TrackballVisibilityMode.auto,
                  ),
                ),
                series: <ChartSeries>[
                  ColumnSeries<ExerciseData, DateTime>(
                    dataSource: exerciseData,
                    xValueMapper: (ExerciseData data, _) => data.exercise_day,
                    yValueMapper: (ExerciseData data, _) => data.calories,
                    name: 'Calories',
                  )
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Plan',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  tempDataPlan.isEmpty ?
                  Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      child: Center(
                        child: Text(
                          'No Plan Yet',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  )
                  :
                  Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tempDataPlan['exercise_name'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      stopTimer();
                                      tempDataPlan = {};
                                    });
                                  },
                                  child: const Text(
                                    'Stop',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500
                                    ),
                                  )
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _timer == null ?
                                      '00:00'
                                      :
                                      getDisplayedTime(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '🔥 ${int.parse(tempDataPlan['duration']) - elapsedTime ~/ 60} Minutes Left',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Est. ${tempDataPlan['duration']} Min',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * 0.7,
                              alignment: MainAxisAlignment.center,
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              leading: const Text(
                                '🐢',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: const Text(
                                '🏆',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              lineHeight: 18,
                              percent: elapsedTime / int.parse(tempDataPlan['duration']) / 60,
                              barRadius: Radius.circular(10),
                              backgroundColor: Colors.white,
                              progressColor: successColor
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if(tempDataPlan['status'] == 'start') {
                                      resumeTimer();
                                    } else {
                                      pauseTimer();
                                    }
                                  },
                                  child: Text(
                                    tempDataPlan['status'] == 'pause' ?
                                    'Start'
                                    :
                                    'On Going',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/dashboard',
                                      arguments: 2
                                    );
                                  },
                                  child: Text(
                                    'Change Plan',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]
          )
        )
      )
    );
  }
}