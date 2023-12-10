import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Screens/event/eventDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class EventCard extends StatefulWidget {
  final Event event;
  String token;

   EventCard({
    Key? key,
    required this.event, required this.token
  }) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
  

    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Card(
        // You can customize the card appearance here
        elevation: 6.0,
        shadowColor: const Color(0xff00689B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Event Image

            Container(
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  image: AssetImage(widget.event.eventImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Event Details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Name
                  Text(
                    widget.event.eventName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Event Description
                  Text(
                    widget.event.description,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  // Number of Participants
                  Text(
                    ' ${widget.event.participants.length} Participants',
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Details Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // Handle menu item selection
                    if (value == 'details') {
                     Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => EventDetails(event: widget.event, token: widget.token)),
);

                    } else if (value == 'edit') {
                      // Handle edit action
                    } else if (value == 'delete') {
                      // Handle delete action
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'details',
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Color(0xff00689B)),
                          SizedBox(width: 8.0),
                          Text('Details',
                              style: TextStyle(color: Color(0xff00689B))),
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8.0),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
