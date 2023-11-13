import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/statistic/component/statistics_daily.dart';
import 'package:gimme/screens/statistic/component/statistics_monthly.dart';
import 'package:gimme/screens/statistic/temp_data/data.dart';
import 'package:percent_indicator/percent_indicator.dart';

const List<String> dropdownPlaceholder = <String>["Daily", "Monthly"];

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String temp = dropdownPlaceholder.first;
  String _statisticState = dropdownPlaceholder.first;
  double? meanDaily = findDailyMean() ?? 0;
  double? meanMonthly = findMonthlyMean() ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: Icon(Icons.arrow_back_rounded,
                                color: Colors.black.withOpacity(0.7), size: 40),
                            onTap: () => Navigator.pop(context),
                          ),
                          Text(
                            "Daily Statistics",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 25,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 30)
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Average Workout',
                                style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 15,
                                    fontFamily: "Montserrat"),
                              ),
                              Text(
                                (_statisticState == dropdownPlaceholder.first
                                        ? meanDaily!.toStringAsFixed(2)
                                        : meanMonthly!.toStringAsFixed(2)) +
                                    ' workout(s)',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"),
                              )
                            ],
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(color: Colors.black.withOpacity(0.2))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: DropdownButton(
                                value: temp,
                                items: [
                                  DropdownMenuItem(
                                    value: dropdownPlaceholder.first,
                                    child: Text(dropdownPlaceholder.first),
                                  ),
                                  DropdownMenuItem(
                                    value: dropdownPlaceholder.last,
                                    child: Text(dropdownPlaceholder.last),
                                  )
                                ],
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                style: const TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 15,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600),
                                onChanged: (String? value) {
                                  setState(() {
                                    temp = value!;
                                    _statisticState = value;
                                    setState(() {});
                                  });
                                },
                                underline: Container(),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: 
                          ((){
                            if(_statisticState == dropdownPlaceholder.first){
                              if(listDaily.length>0){
                                return DailyStatistics();
                              }else{
                                return Center(child: Text("Belum ada data statistik",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat"
                                  ),
                                ));
                              }
                            }else{
                              if (listMonthly.length > 0) {
                                return MonthlyStatistics();
                              } else {
                                return Center(
                                    child: Text(
                                  "Belum ada data statistik",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat"),
                                ));
                              }
                            }
                          }()),
                          // _statisticState == dropdownPlaceholder.first
                          //     ? DailyStatistics()
                          //     : MonthlyStatistics(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Recent Plan',
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                      ),
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color(0xff000000),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Full Strength Workout 🔥',
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat"),
                                  ),
                                  Text(
                                    'Est. 60 min',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 15,
                                        fontFamily: "Montserrat"),
                                  ),
                                  LinearPercentIndicator(
                                    padding: const EdgeInsets.only(top: 5),
                                    barRadius: Radius.circular(2),
                                    lineHeight: 24.0,
                                    percent: 0.5,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.4),
                                    progressColor: Colors.green,
                                    center: Text('30:00',
                                        style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat")),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text('Change Plan',
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 15,
                                                fontFamily: "Montserrat")),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))
                    ]))));
  }
}
