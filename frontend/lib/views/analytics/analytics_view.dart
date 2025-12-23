import 'package:flutter/material.dart';

import 'package:frontend/views/analytics/line_chart_widget.dart';
import 'package:frontend/views/analytics/radar_chart_widget.dart';
import 'package:frontend/views/analytics/recommendations_widget.dart';
import 'package:frontend/views/analytics/section_title_widget.dart';
import 'package:frontend/views/stats_widget.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  final List<String> categories = ['Fantasy', 'Sci-Fi', 'Tech', 'Drama'];

  // TODO: Limit to top 10
  final Map<String, int> commonWords = {
    'Adversity': 6,
    'Apple': 3,
    'Investment': 2,
    'Is': 11,
    'The': 12,
    'Let': 6,
    'My': 19,
    'That': 12,
  };

  final List<double> categoryValues = [5, 3, 4, 4];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).canvasColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StatsWidget(context: context, theme: Theme.of(context)),
            const SizedBox(height: 40),
            SectionTitleWidget(context: context, text: "How about genres?"),
            const SizedBox(height: 10),
            RadarChartWidget(context: context, categories: categories, categoryValues: categoryValues),
            const SizedBox(height: 50),
            SectionTitleWidget(context: context, text: "Are your books well-spoken?"),
            const SizedBox(height: 10),
            LineChartWidget(commonWords: commonWords, context: context),
            const SizedBox(height: 50),
            SectionTitleWidget(context: context, text: "You may also like"),
            const SizedBox(height: 10),
            RecommendationsWidget(context: context),
          ],
        ),
      ),
    );
  }
}