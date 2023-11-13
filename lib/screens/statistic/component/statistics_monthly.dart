import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:gimme/screens/statistic/temp_data/data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

//find max val from listMonthly
findMaxMonthly() {
  int max = 0;
  if(listMonthly.length>0){
    for (int i = 0; i < listMonthly.length; i++) {
      if (listMonthly[i].duration > max) {
        max = listMonthly[i].duration;
      }
    }
    return max;
  }else{
    return 0.0;
  }
}

//find mean val from listMonthly
findMonthlyMean() {
  int sum = 0;
  if(listMonthly.length>0){
    for (int i = 0; i < listMonthly.length; i++) {
      sum += listMonthly[i].duration;
    }
    return sum / listMonthly.length;
  }else{
    return 0.0;
  }
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
      primaryXAxis: DateTimeAxis(
        interval: 1,
        intervalType: DateTimeIntervalType.months,
        dateFormat: DateFormat.yMMM(),
        visibleMinimum: 
        ((){
          if(listMonthly.length > 0){
            listMonthly[0].month;
          }else{
            DateTime.now().month;
          }
        }()),
        visibleMaximum: (() {
          if (listMonthly.length > 4) {
            return listMonthly[0 + 3].month;
          } else {
            return listMonthly[listMonthly.length - 1].month;
          }
        }()),
        majorTickLines: const MajorTickLines(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      primaryYAxis: NumericAxis(
        majorTickLines: const MajorTickLines(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
      ),
      onTooltipRender: (tooltipArgs) {
        tooltipArgs.text == findMaxMonthly().toString()
            ? tooltipArgs.text = "${tooltipArgs.text} workout(s) 🔥"
            : tooltipArgs.text = "${tooltipArgs.text} workout(s)";
      },
      series: <ChartSeries<Statistic_Monthly, DateTime>>[
        ColumnSeries<Statistic_Monthly, DateTime>(
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
