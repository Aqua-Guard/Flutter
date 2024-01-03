import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aquaguard/Services/EventWebService.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class EventDetails extends StatefulWidget {
  final Event event;
  String token;

  EventDetails({Key? key, required this.event, required this.token})
      : super(key: key);

  @override
  State<EventDetails> crreateState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  // Sample data for the event details
  Future<bool?> showConfirmationDialog(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content:
              const Text('Are you sure you want to delete this participation?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
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
                                backgroundImage: NetworkImage(
                                    '${Constantes.urlImgUser}${widget.event.userImage}'),
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
                        child: widget.event.participants.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.event.participants.length,
                                itemBuilder: (context, index) {
                                  final participant =
                                      widget.event.participants[index];
                                  final participantImage =
                                      "${Constantes.urlImgUser}${participant['image']}";
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              participantImage ??
                                                  "assets/images/placeholderImage.jpg"),
                                          radius: 40.0,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(participant['username'] ??
                                            "Unknown User"),
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            bool? confirmed =
                                                await showConfirmationDialog(
                                                    context);
                                            if (confirmed == true) {
                                              setState(() {
                                                widget.event.participants
                                                    .removeAt(index);
                                              });
                                              // User confirmed, you can perform additional actions if needed
                                              EventWebService()
                                                  .deleteParticipation(
                                                      widget.token,
                                                      widget.event.idEvent,
                                                      participant['userId'],context);
                                              SnackBar snackBar =
                                                  const SnackBar(
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.check,
                                                        color: Colors
                                                            .white), // Replace with your desired icon
                                                    SizedBox(
                                                        width:
                                                            8), // Adjust spacing as needed
                                                    Text(
                                                        'Participant Deleted successfully!',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                backgroundColor: Colors.green,
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          },
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          label: const Text('Delete'),
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(16.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/no.png",
                                      height: 100.0,
                                    ),
                                    const SizedBox(height: 8.0),
                                    const Text("No participants"),
                                  ],
                                ),
                              ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
