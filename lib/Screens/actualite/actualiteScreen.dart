import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class NewsScreen extends StatefulWidget {
  String token;
  NewsScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class NewsRating {
  final String newsId;
  final bool isTrue;

  NewsRating({
    required this.newsId,
    required this.isTrue,
  });
}

class _NewsScreenState extends State<NewsScreen> {
  late List<Map<String, dynamic>> newsData = [
    {'id': '1', 'title': 'News 1', 'author': 'Author 1', 'date': '2023-12-12', 'views': 100},
    {'id': '2', 'title': 'News 2', 'author': 'Author 2', 'date': '2023-12-13', 'views': 200},
    {'id': '3', 'title': 'News 3', 'author': 'Author 3', 'date': '2023-12-14', 'views': 150},
  ];

  List<NewsRating> ratings = [
    NewsRating(newsId: '1', isTrue: true),
    NewsRating(newsId: '2', isTrue: false),
    // Add more ratings as needed
  ];

  late TextEditingController _searchController;
  List<Map<String, dynamic>> newsDataOriginal = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    newsDataOriginal = List.from(newsData);
  }

  double calculateGlobalRate(String newsId) {
    int trueCount = ratings.where((rating) => rating.newsId == newsId && rating.isTrue).length;
    int totalCount = ratings.where((rating) => rating.newsId == newsId).length;

    return totalCount == 0 ? 0 : trueCount / totalCount;
  }

  @override
  Widget build(BuildContext context) {
    if (newsData == null) {
      return CircularProgressIndicator();
    }

    num totalViews = newsData.fold<num>(0, (sum, news) => sum + (news['views'] as num));

    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'News List',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff00689B),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_splash_screen.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Text(
                  'Total Views: $totalViews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 60,
                  child: Card(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search by News Title',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              newsData = List.from(newsDataOriginal);
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          newsData = (List<Map<String, dynamic>>.from(newsDataOriginal)
                              .where((news) => news['title'].toLowerCase().contains(value.toLowerCase())) as List<Map<String, dynamic>>);
                        });
                      },
                    ),
                  ),
                ),
                if (newsData.isEmpty)
                  Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/calendar_amico.png",
                            height: 100,
                          ),
                          const SizedBox(height: 8.0),
                          const Text("No News Found"),
                        ]),
                  ),
                if (newsData.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 1,
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.blueGrey,
                              ),
   
                            ),
                            titlesData: FlTitlesData(
                              
                            // leftTitles: SideTitles(showTitles: false)
                            //   bottomTitles: SideTitles(
                            //     showTitles: true,
                            //     getTextStyles: (context, value) => const TextStyle(
                            //       color: Color(0xff7589a2),
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //     margin: 16,
                            //     getTitles: (double value) {
                            //       // Return the title for each bar
                            //       // You can customize this based on your needs
                            //       return value.toInt().toString();
                            //     },
                            //   ),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: newsData.map((news) {
                              return BarChartGroupData(
                                x: newsData.indexOf(news),
                                barRods: [
                                  BarChartRodData(
                                    toY: calculateGlobalRate(news['id']).toDouble(),
                                    color: Colors.blue,
                                    width: 16,
                                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Card(
                          elevation: 4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'News Title',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff00689B)),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Author',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff00689B)),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Date Published',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff00689B)),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Views',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff00689B)),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Rating',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff00689B)),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Actions',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff00689B)),
                                  ),
                                ),
                              ],
                              rows: newsData.map((news) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(news['title'].toString())),
                                    DataCell(Text(news['author'].toString())),
                                    DataCell(Text(news['date'].toString())),
                                    DataCell(Text(news['views'].toString())),
                                    DataCell(
                                      Text(calculateGlobalRate(news['id']).toStringAsFixed(2)),
                                    ),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.info, color: Colors.blue),
                                        onPressed: () {
                                          // Add navigation to news details screen
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ]),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add navigation to add news screen
          },
          backgroundColor: const Color(0xff00689B),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
