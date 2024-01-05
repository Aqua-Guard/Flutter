import 'package:flutter/material.dart';
import 'package:aquaguard/Services/StoreWebService.dart' as networkService;
import 'package:fl_chart/fl_chart.dart';
import 'package:aquaguard/Screens/Store/ProductListScreen.Dart';

class ProductStatisticsScreen extends StatefulWidget {
  @override
  _ProductStatisticsScreenState createState() => _ProductStatisticsScreenState();
}

class _ProductStatisticsScreenState extends State<ProductStatisticsScreen> {
  late Future<List<dynamic>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = networkService.ProductService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Sales Statistics'),
      ),
      body: _buildProductsChart(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Product List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Product Statistics',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProductListScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildProductsChart() {
  return FutureBuilder<List<dynamic>>(
    future: _productsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator()); // Show loading indicator
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}')); // Handle errors gracefully
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No products available.')); // Display message for empty data
      } else {
        final productsData = snapshot.data!;
        final barGroups = _buildBarGroups(productsData); // Extract bar group creation
        return _buildChart(productsData, barGroups);
      }
    },
  );
}

List<BarChartGroupData> _buildBarGroups(List<dynamic> productsData) {
  return productsData.map((productData) {
    if (productData['nbSales'] != null) {
      return BarChartGroupData(
        x: productsData.indexOf(productData),
        barRods: [
          BarChartRodData(
            toY: productData['nbSales'].toDouble(),
            color: Colors.blue,
          ),
        ],
      );
    } else {
      return null; // Handle missing nbSales gracefully
    }
  }).whereType<BarChartGroupData>().toList(); // Filter out null values
}
  Widget _buildChart(List<dynamic> productsData, List<BarChartGroupData> barGroups) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.5,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: barGroups,
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles( // Use AxisTitles for bottom titles
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTitlesWidget: (value, meta) => Text(productsData[value.toInt()]['name'] ?? '', style: TextStyle(color: Colors.black, fontSize: 12)), // Adjust for TitleMeta
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                HorizontalLine(
                  y: 0,
                  color: Colors.black12,
                  strokeWidth: 1,
                ),
              ],
            ),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.blueGrey,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String productName = productsData[group.x.toInt()]['name'] ?? '';
                  return BarTooltipItem(
                    productName + '\n' + (rod.toY).toString(),
                    TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

