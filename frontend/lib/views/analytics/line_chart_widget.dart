import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    super.key,
    required this.commonWords,
    required this.context,
  });

  final Map<String, int> commonWords;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final sortedEntries = commonWords.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final spots = sortedEntries
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.value.toDouble()))
        .toList();

    final chartWidth = sortedEntries.length * 80.0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: chartWidth,
          height: 300,
          child: Padding(
            padding: EdgeInsets.only(right: 40),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: spots.length - 1,
                minY: 0,
                maxY: sortedEntries.first.value.toDouble() + 2,
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, _) {
                        final index = value.toInt();
                        if (index < 0 || index >= sortedEntries.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            sortedEntries[index].key,
                            style: TextStyle(
                              color: Theme.of(context).appBarTheme.foregroundColor,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.amber,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
