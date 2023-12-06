import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aquaguard/Screens/event/eventCard.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final List<Map<String, dynamic>> eventsData = [
    {
      'eventName': 'Event 1',
      'eventDescription': 'Description 1',
      'imageUrl': 'assets/sidi_bou_said.jpg',
      'numberOfParticipants': 50,
    },
    {
      'eventName': 'Event 2',
      'eventDescription': 'Description 2',
      'imageUrl': 'assets/sidi_bou_said.jpg',
      'numberOfParticipants': 30,
    },
    {
      'eventName': 'Event 3',
      'eventDescription': 'Description 3',
      'imageUrl': 'assets/sidi_bou_said.jpg',
      'numberOfParticipants': 30,
    },
     {
      'eventName': 'Event 4',
      'eventDescription': 'Description 4',
      'imageUrl': 'assets/sidi_bou_said.jpg',
      'numberOfParticipants': 30,
    },
     {
      'eventName': 'Event 5',
      'eventDescription': 'Description 5',
      'imageUrl': 'assets/sidi_bou_said.jpg',
      'numberOfParticipants': 30,
    },
  ];

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
            // title: const Text('Post',style: TextStyle( color: Colors.white // Set text color to white
            // Make text bold)

            backgroundColor: const Color(0xff00689B),

            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  color: Colors.white,
                  onPressed: () {
                    // Handle notification icon action
                  },
                ),
                const CircleAvatar(
                  // Replace with your image
                  backgroundImage: AssetImage('assets/images/malek.jpg'),
                )
              ],
            ),
          ),
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
              ListView.builder(
                itemCount: eventsData.length,
                itemBuilder: (context, index) {
                  final eventData = eventsData[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EventCard(
                      eventName: eventData['eventName'],
                      eventDescription: eventData['eventDescription'],
                      imageUrl: eventData['imageUrl'],
                      numberOfParticipants: eventData['numberOfParticipants'],
                    ),
                  );
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Stack(children: [
                    Image.asset(
                      "assets/nav_header.png",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.transparent,
                    //       radius: 40,
                    //       child: Container(
                    //           width: MediaQuery.of(context).size.width * .3,
                    //           height: MediaQuery.of(context).size.height * .3,
                    //           child: Image.asset("assets/profile_pic.png")
                    //       ),
                    //     ),
                    // ),
                  ]),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_rounded),
                  title: const Text('Users'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  tileColor: Color(0xff00689B),
                  leading: const Icon(Icons.event),
                  title: const Text('Events'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.post_add),
                  title: const Text('Posts'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.store),
                  title: const Text('Store'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Reclamation'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
floatingActionButton: FloatingActionButton(
  onPressed: () {
    // Handle the onPressed event when the button is tapped
    // You can navigate to a new screen or perform any other action
  },
  backgroundColor: const Color(0xff00689B),
  shape: const CircleBorder(), // Set FAB background color
  child:  const Icon(
    Icons.add,
    color: Colors.white, // Set the color of the icon to white
  ), // Make the FAB circular
),

        ));
  }
}
