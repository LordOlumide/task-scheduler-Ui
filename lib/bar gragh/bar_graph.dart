import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:task_scheduler/bar%20gragh/bar_data.dart';

import '../constants.dart';

class MyBarGraph extends StatelessWidget {
  final List WeeklyExpense;
  const MyBarGraph({super.key, required this.WeeklyExpense});

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    BarData myBarData = BarData(
        sunAmount: WeeklyExpense[0],
        monAmount: WeeklyExpense[1],
        tueAmount: WeeklyExpense[2],
        wedAmount: WeeklyExpense[3],
        thurAmount: WeeklyExpense[4],
        friAmount: WeeklyExpense[5],
        satAmount: WeeklyExpense[6]);
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
      maxY: 100,
      minY: 0,
      // backgroundColor: ksecondaryColor,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false,),
      titlesData: FlTitlesData(
        show: false,
        // topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        // leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        // rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))
      ),
      barGroups:myBarData.barData
                .map(
                  (data) => BarChartGroupData(x: data.x,
                  barRods: [
                    BarChartRodData(toY: data.y,
                    color: ktertiaryColor,
                    width: 18,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 100,
                      color: Colors.grey[900],
                    )
                    )
                  ]
                  ), 
                  ).toList(),
    ),
    );
  }
}
