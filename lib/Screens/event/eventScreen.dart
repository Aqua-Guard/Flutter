import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Screens/event/eventDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aquaguard/Screens/event/eventCard.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final List<Event> eventsData = [
    Event(
      eventName: 'Clean-up the Sea Tunisia',
      dateDebut: DateTime.parse('2023-01-01'),
      dateFin: DateTime.parse('2023-01-10'),
      lieu: 'Tunis, Tunisia',
      description: 'Join us in our efforts to clean up the beautiful coast of Tunisia. Let\'s protect our marine environment and promote sustainable practices.',
      userImage: 'assets/images/malek.jpg',
      eventImage: 'assets/sidi_bou_said.jpg',
      userName: 'Malek Labidi',
      participants: [
        {'userImage': 'assets/images/malek.jpg', 'userName': 'Malek Labidi'},
        {
          'userImage': 'assets/images/youssef.jpg',
          'userName': 'Youssef Farhat'
        },
          {'userImage': 'assets/images/mohamed.png', 'userName': 'Mohamed Kout'},
        {
          'userImage': 'assets/images/amira.jpg',
          'userName': 'Amira Ben Mbarek'
        },
         
        // Add more participants as needed
      ],
    ),
    Event(
      eventName: 'Clean-upp',
      dateDebut: DateTime.parse('2023-01-01'),
      dateFin: DateTime.parse('2023-01-10'),
      lieu: 'Tunis, Tunisia',
      description: 'Join us in our efforts to clean up the beautiful coast of Tunisia. Let\'s protect our marine environment and promote sustainable practices.',
      userImage: 'assets/images/youssef.jpg',
      eventImage: 'assets/post1.jpg',
      userName: 'Youssef Farhat',
      participants: [
       {'userImage': 'assets/images/malek.jpg', 'userName': 'Malek Labidi'},
      
          {'userImage': 'assets/images/mohamed.png', 'userName': 'Mohamed Kout'},
        {
          'userImage': 'assets/images/amira.jpg',
          'userName': 'Amira Ben Mbarek'
        },
        // Add more participants as needed
      ],
    ),
    Event(
      eventName: 'Opération Nettoyage des Plages',
      dateDebut: DateTime.parse('2023-01-01'),
      dateFin: DateTime.parse('2023-01-10'),
      lieu: 'Event Location',
      description: 'Une initiative communautaire pour nettoyer les plages et protéger l\'environnement.',
      userImage: 'assets/images/mohamed.png',
      eventImage: 'assets/sidi_bou_said.jpg',
      userName: 'Mohamed Kout',
      participants: [
        {'userImage': 'assets/images/malek.jpg', 'userName': 'Malek Labidi'},
        {
          'userImage': 'assets/images/youssef.jpg',
          'userName': 'Youssef Farhat'
        },
          {'userImage': 'assets/images/mohamed.png', 'userName': 'Mohamed Kout'},
        {
          'userImage': 'assets/images/amira.jpg',
          'userName': 'Amira Ben Mbarek'
        },
         {'userImage': 'assets/images/malek.jpg', 'userName': 'Malek Labidi'},
        {
          'userImage': 'assets/images/youssef.jpg',
          'userName': 'Youssef Farhat'
        },
          {'userImage': 'assets/images/mohamed.png', 'userName': 'Mohamed Kout'},
        {
          'userImage': 'assets/images/amira.jpg',
          'userName': 'Amira Ben Mbarek'
        },
        // Add more participants as needed
      ],
    ),
       Event(
      eventName: 'Ocean Cleanup Day',
      dateDebut: DateTime.parse('2023-01-01'),
      dateFin: DateTime.parse('2023-01-10'),
      lieu: 'Sunshine Beach',
      description: 'Une initiative communautaire pour nettoyer les plages et protéger l\'environnement.',
      userImage: 'assets/images/amira.jpg',
      eventImage: 'assets/post1.jpg',
      userName: 'Amira Ben Mbarek',
      participants: [
        {'userImage': 'assets/images/malek.jpg', 'userName': 'Malek Labidi'},
        {
          'userImage': 'assets/images/youssef.jpg',
          'userName': 'Youssef Farhat'
        },
          {'userImage': 'assets/images/mohamed.png', 'userName': 'Mohamed Kout'},
      
        // Add more participants as needed
      ],
    ),
       Event(
      eventName: 'Coastal Cleanup Expedition',
      dateDebut: DateTime.parse('2023-01-01'),
      dateFin: DateTime.parse('2023-01-10'),
      lieu: 'Event Location',
      description: 'Embark on a three-day expedition along the coastline, cleaning up beaches and coastal areas. Help us preserve the beauty of our shores and protect marine life.',
      userImage: 'assets/images/malek.jpg',
      eventImage: 'assets/sidi_bou_said.jpg',
      userName: 'Malek Labidi',
      participants: [
        {'userImage': 'assets/images/malek.jpg', 'userName': 'Malek Labidi'},
        {
          'userImage': 'assets/images/youssef.jpg',
          'userName': 'Youssef Farhat'
        },
          {'userImage': 'assets/images/malek.jpg', 'userName': 'Malek Labidi'},
        {
          'userImage': 'assets/images/youssef.jpg',
          'userName': 'Youssef Farhat'
        },
        // Add more participants as needed
      ],
    ),
       Event(
      eventName: 'Underwater Dive',
      dateDebut: DateTime.parse('2023-01-01'),
      dateFin: DateTime.parse('2023-01-10'),
      lieu: 'Event Location',
      description: 'Calling all scuba divers! Join us for an underwater cleanup dive to remove garbage and debris from the ocean floor. Let\'s keep our marine environment clean and safe.',
      userImage: 'assets/images/malek.jpg',
      eventImage: 'assets/post1.jpg',
      userName: 'Malek Labidi',
      participants: [
        {'userImage': 'assets/images/malek.jpg', 'userName': 'Malek Labidi'},
        {
          'userImage': 'assets/images/youssef.jpg',
          'userName': 'Youssef Farhat'
        },
          {'userImage': 'assets/images/malek.jpg', 'userName': 'Malek Labidi'},
        {
          'userImage': 'assets/images/youssef.jpg',
          'userName': 'Youssef Farhat'
        },
        // Add more participants as needed
      ],
    ),
    // Add more events as needed
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetails(
                event: eventData,
              ),
            ),
          );
        },
        child: EventCard(
          event: eventData,
        ),
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
            child: const Icon(
              Icons.add,
              color: Colors.white, // Set the color of the icon to white
            ), // Make the FAB circular
          ),
        ));
  }
}
