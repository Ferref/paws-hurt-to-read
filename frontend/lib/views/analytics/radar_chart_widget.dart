import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';


class RadarChartWidget extends StatelessWidget {
  const RadarChartWidget({
    super.key,
    required this.context,
    required this.categories,
    required this.categoryValues,
  });

  final BuildContext context;
  final List<String> categories;
  final List<double> categoryValues;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          color: Colors.deepPurpleAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: RadarChart(
              RadarChartData(
                tickBorderData: const BorderSide(color: Colors.white24),
                ticksTextStyle: const TextStyle(color: Colors.transparent),
                tickCount: 5,
                radarBorderData: const BorderSide(color: Colors.white24),
                gridBorderData: const BorderSide(color: Colors.white24),
                titleTextStyle: TextStyle(
                  color: Theme.of(context).canvasColor,
                  fontSize: 20,
                ),
                getTitle: (index, _) =>
                    RadarChartTitle(text: categories[index]),
                dataSets: [
                  RadarDataSet(
                    fillColor: Colors.amber.withAlpha(150),
                    borderColor: Colors.white,
                    entryRadius: 4,
                    dataEntries: categoryValues
                        .map((v) => RadarEntry(value: v))
                        .toList(),
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
