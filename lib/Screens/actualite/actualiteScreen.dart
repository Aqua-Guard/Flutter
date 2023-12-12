import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aquaguard/Models/actualite.dart';
import 'package:aquaguard/Screens/actualite/addActualite.dart';
import 'package:aquaguard/Services/ActualiteWebService.dart';

class NewsRating {
  final String newsId;
  final bool isTrue;

  NewsRating({
    required this.newsId,
    required this.isTrue,
  });
}

class NewsScreen extends StatefulWidget {
  String token;
  NewsScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late List<Actualite> newsData = [];
  late TextEditingController _searchController;
  List<Actualite> newsDataOriginal = [];
  List<NewsRating> ratings = [
    NewsRating(newsId: '1', isTrue: true),
    NewsRating(newsId: '2', isTrue: false),
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    ActualiteWebService().fetchActualite().then((actualite) {
      setState(() {
        newsData = actualite;
        newsDataOriginal = List.from(newsData);
      });
    }).catchError((error) {
      print('Error fetching actualite: $error');
    });
  }

  double calculateGlobalRate(String newsId) {
    int trueCount = ratings
        .where((rating) => rating.newsId == newsId && rating.isTrue)
        .length;
    int totalCount =
        ratings.where((rating) => rating.newsId == newsId).length;

    return totalCount == 0 ? 0 : trueCount / totalCount;
  }

  @override
  Widget build(BuildContext context) {
    if (newsData == null) {
      return CircularProgressIndicator();
    }

    num totalViews = newsData.fold<num>(
        0, (sum, news) => sum + (news.views as num));

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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0),
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
                              newsData =
                                  List.from(newsDataOriginal);
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          newsData = newsDataOriginal
                              .where((news) => news.title
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                          print(newsData);
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
                                    'Description',
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
                                    DataCell(Text(news.title)),
                                    DataCell(Text(news.description)),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.info,
                                            color: Colors.blue),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNews(token: widget.token)),
            );
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

