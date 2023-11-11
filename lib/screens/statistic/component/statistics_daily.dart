import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:gimme/screens/statistic/temp_data/data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//find max val from listdaily
findMaxDaily() {
  int max = 0;
  for (int i = 0; i < listDaily.length; i++) {
    if (listDaily[i].duration > max) {
      max = listDaily[i].duration;
    }
  }
  return max;
}

//find mean val from listdaily
findDailyMean() {
  int sum = 0;
  for (int i = 0; i < listDaily.length; i++) {
    sum += listDaily[i].duration;
  }
  return sum / listDaily.length;
}

class DailyStatistics extends StatefulWidget {
  const DailyStatistics({super.key});

  @override
  State<DailyStatistics> createState() => _DailyStatisticsState();
}

class _DailyStatisticsState extends State<DailyStatistics> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
        majorTickLines: MajorTickLines(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
        labelStyle: TextStyle(
          color: Colors.black,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      primaryYAxis: NumericAxis(
        majorTickLines: MajorTickLines(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
        labelStyle: TextStyle(
          color: Colors.black,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      onTooltipRender: (tooltipArgs) {
        tooltipArgs.text == findMaxDaily().toString()
            ? tooltipArgs.text = "${tooltipArgs.text} minutes 🔥"
            : tooltipArgs.text = "${tooltipArgs.text} minutes";
      },
      series: <ChartSeries<Statistic_Daily, String>>[
        ColumnSeries<Statistic_Daily, String>(
          dataSource: listDaily,
          width: 0.5,
          xValueMapper: (Statistic_Daily data, _) => data.date,
          yValueMapper: (Statistic_Daily data, _) => data.duration,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
          pointColorMapper: (Statistic_Daily data, _) {
            if (data.duration == findMaxDaily()) {
              return Color(0xFFDAF5E6);
            } else {
              return Color(0xFFECFAFD);
            }
          },
        )
      ],
      tooltipBehavior: 
      TooltipBehavior(
          elevation: 5,
          enable: true,
          header: '',
          format: 'point.y',
          color: Colors.white,
          textStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
          )),
    );
  }
}
