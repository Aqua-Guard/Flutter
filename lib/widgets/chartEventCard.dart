import 'package:aquaguard/Screens/event/eventScreen.dart';
import 'package:aquaguard/Services/EventWebService.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartEventCard extends StatefulWidget {
  String token;
    ChartEventCard({Key? key, required this.token}) : super(key: key);


  @override
  State<ChartEventCard> createState() => _ChartEventCardState();
}

class _ChartEventCardState extends State<ChartEventCard> {
  late List<Map<String, dynamic>> eventData = [];

  @override
  void initState() {
    super.initState();
    EventWebService().fetchEventsNbParticipants(widget.token).then((events) {
      setState(() {
        eventData = events;
      });
    }).catchError((error) {
      // Handle the error, e.g., show an error message to the user
      print('Error fetching events state: $error');
    });
  }

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
                MaterialPageRoute(builder: (context) =>  EventScreen(token : widget.token)),
              );
            },
          ),
        ],
      );

  Widget _buildBarChart(List<Map<String, dynamic>> eventData) {
    List<BarChartGroupData> barChartGroups = [];

    for (int i = 0; i < eventData.length; i++) {
      final double value = eventData[i]['nbParticipants'].toDouble();
      final String label = eventData[i]['eventName'];

      barChartGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
              color: Colors.blue, // You can customize the color as needed
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }

    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final value = rod.toY.toInt();
              return BarTooltipItem(
                value.toString(),
                TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                if (value >= 0 && value < eventData.length) {
                  final String label = eventData[value.toInt()]['eventName'];
                  return Text(
                    label,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: barChartGroups,
      ),
    );
  }
}
