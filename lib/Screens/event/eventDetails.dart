import 'package:aquaguard/Models/Event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  // Sample data for the event details

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
          appBar: AppBar(
            title: const Text('Event Details',
                style: TextStyle(
                  color: Colors.white,
                )),
            backgroundColor: const Color(0xff00689B),
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background_splash_screen.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.event.eventName,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(widget.event.description),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors
                                        .blue, // Couleur de l'icône du calendrier
                                  ),
                                  Text(
                                    ' From ${DateFormat('yyyy-MM-dd').format(widget.event.dateDebut)} To ${DateFormat('yyyy-MM-dd').format(widget.event.dateFin)}',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors
                                        .red, // Couleur de l'icône de l'emplacement
                                  ),
                                  Text(' ${widget.event.lieu}'),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              const Text(
                                'Organizer',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(widget.event.userImage),
                                radius: 40.0,
                              ),
                              const SizedBox(height: 8.0),
                              Text(widget.event.userName),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Participants',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        height: 200.0, // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.event.participants.length,
                          itemBuilder: (context, index) {
                            final participant =
                                widget.event.participants[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(participant['userImage']),
                                    radius: 40.0,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(participant['userName']),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Handle Edit button tap
                                // You can navigate to the edit screen or perform any other action
                              },
                              icon: Icon(Icons.edit, color: Colors.amber[700]),
                              label: const Text('Edit'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0), // Add space between buttons
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Handle Delete button tap
                                  // You can show a confirmation dialog and delete the event if confirmed
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                label: const Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
