import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/Services/EventWebService.dart';
import 'package:aquaguard/Services/PostWebService.dart';
import 'package:aquaguard/widgets/LatestPostCard.dart';
import 'package:aquaguard/widgets/barChartCard.dart';
import 'package:aquaguard/widgets/chartEventCard.dart';
import 'package:aquaguard/widgets/totalEventCard.dart';
import 'package:aquaguard/widgets/totalPostsCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Components/MyAppBar.dart';
import '../Components/MyDrawer.dart';

class HomeScreen extends StatefulWidget {
  String token;

  HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late List<Event> eventsData = [];

  late List<Post> postData = [];

  @override
  void initState() {
    super.initState();
    EventWebService().fetchEvents(widget.token).then((events) {
      setState(() {
        eventsData = events;
      });
    }).catchError((error) {
      // Handle the error, e.g., show an error message to the user
      print('Error fetching events: $error');
    });
    PostWebService()
        .getAllPosts(widget.token)
        .then((posts) => {
              setState(() {
                postData = posts;
              })
            })
        .catchError((error) {
      print("Error Fetch posts: " + error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          // This will change the drawer icon color
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        child: Scaffold(
          appBar: MyAppBar(),
          body: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_splash_screen.png'),
                  fit: BoxFit
                      .cover, // This will fill the background of the container, you can change it as needed.
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TotalEventsCard(
                                totalEvents: eventsData.length)),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TotalPostsCard(
                              totalPosts: postData
                                  .length), // Replace 100 with your total posts count
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: ChartEventCard(token: widget.token),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BarChartCard(token: widget.token),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LatestPostCard(
                                token: widget.token, postData: postData),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
          drawer: MyDrawer(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ));
  }
}
