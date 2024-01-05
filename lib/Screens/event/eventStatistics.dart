import 'package:aquaguard/Components/MyAppBar.dart';
import 'package:aquaguard/Components/MyDrawer.dart';
import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Services/EventWebService.dart';
import 'package:aquaguard/widgets/chartEventCard.dart';
import 'package:aquaguard/widgets/totalEventCard.dart';
import 'package:flutter/material.dart';

class EventStatistics extends StatefulWidget {
  String token;
  EventStatistics({Key? key, required this.token}) : super(key: key);

  @override
  State<EventStatistics> createState() => _EventStatisticsState();
}

class _EventStatisticsState extends State<EventStatistics> {
  //int _selectedIndex = 2;
  late List<Event> eventsData = [];

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
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_splash_screen.png'),
                  fit: BoxFit
                      .cover, // This will fill the background of the container, you can change it as needed.
                ),
              ),
            ),
            Column(children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TotalEventsCard(totalEvents: eventsData.length)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ChartEventCard(token : widget.token),
                ),
              ),
            ]),
          ],
        ),
       /* drawer: MyDrawer(
          selectedIndex: _selectedIndex,
          onItemTapped: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),*/
      ),
    );
  }
}
