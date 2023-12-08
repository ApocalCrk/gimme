// ignore_for_file: library_private_types_in_public_api, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/statistic/controller/statisticController.dart';
import 'package:gimme/screens/statistic/model/History.dart';
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
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
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
        averageWorkout = data;
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
                  interval: 30,
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
                            Text(
                              'Full Chest Workout',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '50 Min',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '🔥 500 Calories',
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
                                  'Est. 20 Min',
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
                              animation: true,
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
                              percent: 0.5,
                              barRadius: Radius.circular(10),
                              backgroundColor: Colors.white,
                              progressColor: successColor
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
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
                                Text(
                                  'Change Plane',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500
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