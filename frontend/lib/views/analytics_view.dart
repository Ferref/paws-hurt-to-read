import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStats(theme),
          const SizedBox(height: 40),
          _buildSectionTitle("How about genres?"),
          const SizedBox(height: 10),
          _buildRadarChart(),
          const SizedBox(height: 50),
          _buildSectionTitle("Are your books well-spoken?"),
          const SizedBox(height: 10),
          _buildLineChart(),
          const SizedBox(height: 50),
          _buildSectionTitle("You may also like"),
          const SizedBox(height: 10),
          _buildRecommendations(),
        ],
      ),
    );
  }

  Widget _buildStats(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Owned books: 10 \nDownloaded books: 6 \nRead books: 4',
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(color: Colors.white, fontSize: 26),
    );
  }

  Widget _buildRadarChart() {
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
                titleTextStyle: const TextStyle(
                  color: Colors.white,
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

  Widget _buildLineChart() {
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
                            style: const TextStyle(
                              color: Colors.white,
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

  Widget _buildRecommendations() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              CarouselSlider(
                items: [
                  Column(
                    children: [
                      Container(
                        // TODO: Make book cover bigger, with managing overflow
                        height: 200,
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                        onPressed: () {},
                        child: Text(
                          "See details",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ],
                options: CarouselOptions(
                  height: 500,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 2 / 3,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}