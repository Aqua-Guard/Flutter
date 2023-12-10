import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Screens/event/addEventForm.dart';
import 'package:aquaguard/Screens/event/eventDetails.dart';
import 'package:aquaguard/Services/EventWebService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  String token;
  EventScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late List<Event> eventsData = [];
  late TextEditingController _searchController;
  List<Event> eventsDataOriginal = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    eventsDataOriginal = eventsData;
    EventWebService().fetchEvents(widget.token).then((events) {
      setState(() {
        eventsData = events;
        eventsDataOriginal = List.from(eventsData);
      });
    }).catchError((error) {
      // Handle the error, e.g., show an error message to the user
      print('Error fetching events: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<Event> eventsDataCopy = List.from(eventsDataOriginal);
    // Check if eventsData is null or empty to handle loading or no data scenarios
    if (eventsData == null) {
      return CircularProgressIndicator(); // Show loading indicator or another widget
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
              child: Column(children: [
                Container(
                  height: 60, // Adjust the height as needed
                  child: Card(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search by Event Name',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              eventsData = eventsDataOriginal;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          eventsData = eventsDataOriginal
                              .where((event) => event.eventName
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                          print(eventsData);
                        });
                      },
                    ),
                  ),
                ),
                if (eventsData.isEmpty)
                  Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/calendar_amico.png",
                            height: 100,
                          ),
                          const SizedBox(height: 8.0),
                          const Text("No Events Found"),
                        ]),
                  ),
                if (eventsData.isNotEmpty)
                  SingleChildScrollView(
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
                                    icon: const Icon(Icons.info,
                                        color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EventDetails(
                                            event: event,
                                            token: widget.token,
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
              ]),
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
