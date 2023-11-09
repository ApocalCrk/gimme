import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:gimme/screens/statistic/tempData/data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//find max val from listdaily
int findMaxDaily(){
  int max = 0;
  for(int i = 0; i < listDaily.length; i++){
    if(listDaily[i].duration > max){
      max = listDaily[i].duration;
    }
  }
  return max;
}

int findMaxMonthly(){
  int max = 0;
  for(int i = 0; i < listMonthly.length; i++){
    if(listMonthly[i].duration > max){
      max = listMonthly[i].duration;
    }
  }
  return max;

}

double findDailyMean(){
  int sum = 0;
  for(int i = 0; i < listDaily.length; i++){
    sum += listDaily[i].duration;
  }
  return sum/listDaily.length;
}

double findMonthlyMean(){
  int sum = 0;
  for(int i = 0; i < listMonthly.length; i++){
    sum += listMonthly[i].duration;
  }
  return sum/listMonthly.length;

}

SfCartesianChart DailyStatistics(){
  return SfCartesianChart(
    legend: Legend(isVisible: false),
    primaryXAxis: CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
      axisLine: AxisLine(width: 0),
    ),
    primaryYAxis: NumericAxis(
      majorGridLines: MajorGridLines(width: 0),
      axisLine: AxisLine(width: 0),
    ),
    series: <ChartSeries<Statistic_Daily, String>>[
      ColumnSeries<Statistic_Daily, String>(
        dataSource: listDaily,
        width: 0.5,
        xValueMapper: (Statistic_Daily data, _) => data.date,
        yValueMapper: (Statistic_Daily data, _) => data.duration,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),

        pointColorMapper: (Statistic_Daily data, _) {
          if(data.duration == findMaxDaily()){
            return Color(0xFFDAF5E6);
          }else{
            return Color(0xFFECFAFD);
          }
        }, 
      )
    ],
    tooltipBehavior: TooltipBehavior(
      enable: true,
      header: '',
      format: 'point.y workout(s)',
      color: Colors.black,
      textStyle: TextStyle(
        color: Colors.white
      )
    ),
  );
}

SfCartesianChart MonthlyStatistics(){
  return SfCartesianChart(
    legend: Legend(isVisible: false),
    primaryXAxis: CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
      axisLine: AxisLine(width: 0),
    ),
    primaryYAxis: NumericAxis(
      majorGridLines: MajorGridLines(width: 0),
      axisLine: AxisLine(width: 0),
    ),
    series: <ChartSeries<Statistic_Monthly, String>>[
      ColumnSeries<Statistic_Monthly, String>(
        dataSource: listMonthly,
        width: 0.5,
        xValueMapper: (Statistic_Monthly data, _) => data.month,
        yValueMapper: (Statistic_Monthly data, _) => data.duration,
        borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        pointColorMapper: (Statistic_Monthly data, _) {
          if(data.duration == findMaxMonthly()){
            return Color(0xFFDAF5E6);
          }else{
            return Color(0xFFECFAFD);
          }
        }
      )
    ],
    tooltipBehavior: TooltipBehavior(
        enable: true,
        header: '',
        format: 'point.y workout(s)',
        color: Colors.black,
        textStyle: TextStyle(color: const Color.fromARGB(255, 40, 39, 39))),
  );
}