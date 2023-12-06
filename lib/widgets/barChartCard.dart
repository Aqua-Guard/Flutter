import 'package:aquaguard/data/postChartData.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartCard extends StatelessWidget {
    final List<double> postCounts = [12, 15, 10, 18, 20, 17, 14];
  @override
  Widget build(BuildContext context) {
    // Sample data representing the number of posts per day

    return Container(
      height: 400,
      padding: const EdgeInsets.all(16),
      decoration: _buildDecoration(),
      child: Column(
        children: [
          _buildChartTitle(),
          SizedBox(height: 20),
          Expanded(child: _buildBarChart(postCounts)),
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
              offset: Offset(0, 1))
        ],
      );

  Widget _buildChartTitle() => Column(
        children: const [
          Text('Weekly Post Analysis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Number of Posts per Day',
              style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      );

  Widget _buildBarChart(postCounts) => BarChart(
    
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.grey,
                getTooltipItem: (_a, _b, _c, _d) => null),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  );
                  String text;
                  switch (value.toInt()) {
                    case 0:
                      text = 'Mon';
                      break;
                    case 1:
                      text = 'Tue';
                      break;
                    case 2:
                      text = 'Wed';
                      break;
                    case 3:
                      text = 'Thu';
                      break;
                    case 4:
                      text = 'Fri';
                      break;
                    case 5:
                      text = 'Sat';
                      break;
                    case 6:
                      text = 'Sun';
                      break;
                    default:
                      text = '';
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 8.0,
                    child: Text(text, style: style),
                  );
                },
                reservedSize: 40,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: PostChartData.getBarChartItems(postCounts),
        ),
      );
}
