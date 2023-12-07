import 'package:aquaguard/Screens/event/eventScreen.dart';
import 'package:aquaguard/data/postChartData.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartEventCard extends StatelessWidget {
  final List<Map<String, dynamic>> eventData = [
    {'eventName': 'Event A', 'participants': 12},
    {'eventName': 'Event B', 'participants': 15},
    {'eventName': 'Event C', 'participants': 10},
    {'eventName': 'Event D', 'participants': 18},
    {'eventName': 'Event E', 'participants': 20},
    {'eventName': 'Event F', 'participants': 17},
    {'eventName': 'Event G', 'participants': 14},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(16),
      decoration: _buildDecoration(),
      child: Column(
        children: [
          _buildChartTitle(context),
          SizedBox(height: 20),
          Expanded(child: _buildBarChart(eventData)),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      );

  Widget _buildChartTitle(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Text('Event Analysis',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Number of Participants per Event',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          TextButton(
            child: const Text('See All'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventScreen()),
              );
            },
          ),
        ],
      );

  Widget _buildBarChart(List<Map<String, dynamic>> eventData) => BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItem: (_a, _b, _c, _d) => null,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  return Text(
                    eventData[value.toInt()]['eventName'],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: PostChartData.getBarChartItems(
              eventData.map((data) => data['participants'] as double).toList()),
        ),
      );
}
