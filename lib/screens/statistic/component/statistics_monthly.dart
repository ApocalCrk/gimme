import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:gimme/screens/statistic/temp_data/data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//find max val from listMonthly
findMaxMonthly() {
  int max = 0;
  for (int i = 0; i < listMonthly.length; i++) {
    if (listMonthly[i].duration > max) {
      max = listMonthly[i].duration;
    }
  }
  return max;
}

//find mean val from listMonthly
findMonthlyMean() {
  int sum = 0;
  for (int i = 0; i < listMonthly.length; i++) {
    sum += listMonthly[i].duration;
  }
  return sum / listMonthly.length;
}

class MonthlyStatistics extends StatefulWidget {
  const MonthlyStatistics({super.key});

  @override
  State<MonthlyStatistics> createState() => _MonthlyStatisticsState();
}

class _MonthlyStatisticsState extends State<MonthlyStatistics> {

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: const Legend(isVisible: false),
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
        tooltipArgs.text == findMaxMonthly().toString()
            ? tooltipArgs.text = "${tooltipArgs.text} minutes 🔥"
            : tooltipArgs.text = "${tooltipArgs.text} minutes";
      },
      series: <ChartSeries<Statistic_Monthly, String>>[
        ColumnSeries<Statistic_Monthly, String>(
            dataSource: listMonthly,
            width: 0.5,
            xValueMapper: (Statistic_Monthly data, _) => data.month,
            yValueMapper: (Statistic_Monthly data, _) => data.duration,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            pointColorMapper: (Statistic_Monthly data, _) {
              if (data.duration == findMaxMonthly()) {
                return Color(0xFFDAF5E6);
              } else {
                return Color(0xFFECFAFD);
              }
            })
      ],
      tooltipBehavior: TooltipBehavior(
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
