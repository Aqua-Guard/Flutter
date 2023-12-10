import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Screens/event/addEventForm.dart';
import 'package:aquaguard/Screens/event/eventDetails.dart';
import 'package:aquaguard/Services/EventWebService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late List<Event> eventsData = [];

  @override
  void initState() {
    super.initState();
    EventWebService().fetchEvents().then((events) {
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
    // Check if eventsData is null or empty to handle loading or no data scenarios
    if (eventsData == null) {
      return CircularProgressIndicator(); // Show loading indicator or another widget
    } else if (eventsData.isEmpty) {
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
                'Events List',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xff00689B),
            ),
            body:Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_splash_screen.png'),
              fit: BoxFit.cover,
            ),
          ),
          child:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/calendar_amico.png",
                    height: 100,
                  ),
                  const SizedBox(height: 8.0),
                  const Text("No Events Found"),
                ],
              ),
            ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddEventForm()),
                );
              },
              backgroundColor: const Color(0xff00689B),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ));
    }

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
            'Events List',
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Card(
                  elevation: 4,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Event Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff00689B)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Location',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff00689B)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Start Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff00689B)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'End Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff00689B)),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Participants',
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
                      rows: eventsData.map((event) {
                        return DataRow(
                          cells: [
                            DataCell(Text(event.eventName)),
                            DataCell(Text(event.lieu)),
                            DataCell(Text(event.dateDebut
                                .toString()
                                .characters
                                .take(10)
                                .toString())),
                            DataCell(Text(event.dateFin
                                .toString()
                                .characters
                                .take(10)
                                .toString())),
                            DataCell(
                                Text(event.participants.length.toString())),
                            DataCell(
                              IconButton(
                                icon:
                                    const Icon(Icons.info, color: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventDetails(
                                        event: event,
                                      ),
                                    ),
                                  );
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
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddEventForm()),
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
