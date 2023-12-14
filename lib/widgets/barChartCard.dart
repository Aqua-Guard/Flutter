import 'package:aquaguard/Models/postCount.dart';
import 'package:aquaguard/Services/PostWebService.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
 // Import the PostCount model

class BarChartCard extends StatefulWidget {
  final String token;

  BarChartCard({Key? key, required this.token}) : super(key: key);

  @override
  _BarChartCardState createState() => _BarChartCardState();
}

class _BarChartCardState extends State<BarChartCard> {
  late List<PostCount> postCounts = []; // Initialize with zeros
  bool _isLoaded = false; // To track if the data is loaded

  @override
  void initState() {
    super.initState();
    _fetchPostData();
    
  }

  void _fetchPostData() async {
    try {
      List<PostCount> postCountsData = await PostWebService().getPostsPerWeek(widget.token);
      setState(() {
        postCounts = postCountsData;
        _isLoaded = true;
        print('--------------------------------'+postCountsData.length.toString());
      });
    } catch (error) {
      print('Error fetching post counts: $error');
      // Handle the error appropriately
    }
  }



  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding:  EdgeInsets.all(16),
      decoration: _buildDecoration(),
      child: Column(
        children: [
          _buildChartTitle(context),
          SizedBox(height: 20),
          Expanded(child: _buildBarChart(postCounts)),//Undefined name 'postCountsData'.
//Try correcting the name to one that is defined, or defining the name.dartundefined_identifier
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

  Widget _buildChartTitle(BuildContext context) => const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
            children: [
              Text('Post Analysis',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Number of Post per Day',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      );

  Widget _buildBarChart(List<PostCount> postCount) {
    List<BarChartGroupData> barChartGroups = [];

    for (int i = 0; i < postCount.length; i++) {
      final double value = postCount[i].count.toDouble();
      final String label = postCount[i].day;

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
                if (value >= 0 && value < postCount.length) {
                  final String label = postCount[value.toInt()].day.toString();
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
