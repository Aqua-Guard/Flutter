import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Screens/event/addEventForm.dart';
import 'package:aquaguard/Screens/event/eventDetails.dart';
import 'package:aquaguard/Services/EventWebService.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

Widget buildEventList(DateTime selectedDay) {
  List<Event> eventsForDay = eventsData
      .where((event) =>
          isSameDay(event.dateDebut, selectedDay) ||
          (event.dateDebut.isBefore(selectedDay) &&
              event.dateFin.isAfter(selectedDay)))
      .toList();

  return Padding(
    padding: const EdgeInsets.all(8.0), // Add padding for the entire ListView
    child: Container(
      height: 200, // Set a finite height for the ListView
      child: ListView.builder(
        itemCount: eventsForDay.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Set your border color
                width: 1.0, // Set your border width
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)), // Optional: Add border radius
            ),
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                eventsForDay[index].eventName,
                style: TextStyle(
                  // Optional: Adjust the text style
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Add more details if needed
            ),
          );
        },
      ),
    ),
  );
}




  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
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
              child: Row(children: [
                Expanded(
                  child: Column(children: [
                    Container(
                      height: 60, // Adjust the height as needed
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
                                height: 400,
                                width: 400,
                              ),
                              const SizedBox(height: 8.0),
                              const Text("No Events Found"),
                            ]),
                      ),
                    if (eventsData.isNotEmpty)
                      Expanded(
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
                                      'Event Image',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff00689B)),
                                    ),
                                  ),
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
                                      DataCell(
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            '${Constantes.urlImgEvent}${event.eventImage}',
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
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
                                      DataCell(Text(event.participants.length
                                          .toString())),
                                      DataCell(
                                        IconButton(
                                          icon: const Icon(Icons.info,
                                              color: Colors.blue),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EventDetails(
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
                      ),
                  ]),
                ),
                Expanded(
                  child: SizedBox(
                    //height: 300, // Adjust the height as needed
                    child: Card(
                      elevation: 4,
                      child: Column(children: [
                        TableCalendar(
                          firstDay: DateTime.utc(2023, 1, 1),
                          lastDay: DateTime.utc(3031, 12, 31),
                          focusedDay: _focusedDay,
                          calendarFormat: _calendarFormat,
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
                          eventLoader: (day) {
                            List<Event> eventsForDay = eventsData
                                .where((event) =>
                                    isSameDay(event.dateDebut, day) ||
                                    (event.dateDebut.isBefore(day) &&
                                        event.dateFin.isAfter(day)))
                                .toList();
                                
                            return eventsForDay
                                .map((event) => event.eventName)
                                .toList();
                          },
                          calendarStyle: const CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Color(0xff00689B),
                              shape: BoxShape.circle,
                            ),
                          ),
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: TextStyle(fontSize: 20),
                          ),
                        
                        ),
                        if (_selectedDay != null) buildEventList(_selectedDay),
                      ]),
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
              MaterialPageRoute(
                  builder: (context) => AddEventForm(token: widget.token)),
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
