import 'dart:html';

import 'package:aquaguard/Components/MyAppBar.dart';
import 'package:aquaguard/Components/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:aquaguard/Models/actualite.dart';
import 'package:aquaguard/Screens/actualite/addActualite.dart';
import 'package:aquaguard/Services/ActualiteWebService.dart';
import 'package:aquaguard/screens/actualite/actualitedetailscrean.dart';

class NewsScreen extends StatefulWidget {
  String token;

  NewsScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedIndex = 7;
  late List<Actualite> newsData = [];
  late TextEditingController _searchController;
  List<Actualite> newsDataOriginal = [];
  bool isSmartSearchMode = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    ActualiteWebService().fetchActualite(widget.token).then((actualite) {
      setState(() {
        newsData = actualite;
        newsDataOriginal = List.from(newsData);
      });
    }).catchError((error) {
      print('Error fetching actualite: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (newsData.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    num totalViews = newsData.fold<num>(0, (sum, news) => sum + (news.views as num));

    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      child: Scaffold(
        appBar: MyAppBar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_splash_screen.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Total Views: $totalViews',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSearchBar(),
                    const SizedBox(height: 30),
                    _buildDataTable(),
                    const SizedBox(height: 16),
                    _buildSwitchButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNews(token: widget.token),
              ),
            );
          },
          backgroundColor: const Color(0xff00689B),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        drawer: MyDrawer(
          selectedIndex: _selectedIndex,
          onItemTapped: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 60,
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _onClearSearch();
                    },
                  ),
                ),
                onChanged: (value) {
                  if (!isSmartSearchMode) {
                    _onSearch(value);
                  }
                },
              ),
            ),
            if (isSmartSearchMode)
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  var about = _searchController.text;
print('//////=-------------============----------------========== $about');
               _onSmartSearch(about);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    if (newsData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/calendar_amico.png",
              height: 100,
            ),
            const SizedBox(height: 8.0),
            const Text("No News Found"),
          ],
        ),
      );
    }

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                        color: Color(0xff00689B),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: 150,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff00689B),
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Actions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff00689B),
                      ),
                    ),
                  ),
                ],
                rows: newsData.map((news) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          news.title,
                          softWrap: true,
                        ),
                      ),
                      DataCell(
                        Container(
                          width: 150,
                          child: Text(
                            news.description,
                            softWrap: true,
                          ),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.info, color: Colors.blue),
                          onPressed: () {
                           _navigateToNewsDetail(news);                          },
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
    );
  }

  Widget _buildSwitchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Smart Search Mode'),
        Switch(
          value: isSmartSearchMode,
          onChanged: (value) {
            setState(() {
              isSmartSearchMode = value;
              _onClearSearch();
            });
          },
        ),
      ],
    );
  }

  void _onSearch(String value) {
    setState(() {
      newsData = newsDataOriginal
          .where((news) => news.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _onClearSearch() {
    setState(() {
      _searchController.clear();
      newsData = List.from(newsDataOriginal);
    });
  }
 void _navigateToNewsDetail(Actualite news) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => newsdetail(token: widget.token, news: news),
      ),
    );
  }
  void _onSmartSearch(String value) async {
    print('//////=-------------============----------------========== $value');

    List<Actualite> result =
        await ActualiteWebService().SmartsearchActualites(widget.token, value, context);
    setState(() {
      newsData = result;
    });
  }
}
