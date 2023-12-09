import 'package:aquaguard/Components/MyAppBar.dart';
import 'package:aquaguard/Components/MyDrawer.dart';
import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/widgets/chartEventCard.dart';
import 'package:aquaguard/widgets/totalEventCard.dart';
import 'package:flutter/material.dart';

class EventStatistics extends StatefulWidget {
  const EventStatistics({Key? key}) : super(key: key);

  @override
  State<EventStatistics> createState() => _EventStatisticsState();
}

class _EventStatisticsState extends State<EventStatistics> {
  int _selectedIndex = 2;
  final List<Event> eventsData = [
    Event(
      eventName: 'Clean-up the Sea Tunisia',
      dateDebut: DateTime.parse('2023-01-01'),
      dateFin: DateTime.parse('2023-01-10'),
      lieu: 'Tunis, Tunisia',
      description:
          'Join us in our efforts to clean up the beautiful coast of Tunisia. Let\'s protect our marine environment and promote sustainable practices.',
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
      description:
          'Join us in our efforts to clean up the beautiful coast of Tunisia. Let\'s protect our marine environment and promote sustainable practices.',
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
      description:
          'Une initiative communautaire pour nettoyer les plages et protéger l\'environnement.',
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
      description:
          'Une initiative communautaire pour nettoyer les plages et protéger l\'environnement.',
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
      description:
          'Embark on a three-day expedition along the coastline, cleaning up beaches and coastal areas. Help us preserve the beauty of our shores and protect marine life.',
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
      description:
          'Calling all scuba divers! Join us for an underwater cleanup dive to remove garbage and debris from the ocean floor. Let\'s keep our marine environment clean and safe.',
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
              Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 600, // Adjust the width as needed
                  height: 400, // Adjust the height as needed
                  child: ChartEventCard(),
                ),
              ),
            ]),
          ],
        ),
        drawer: MyDrawer(
          selectedIndex: _selectedIndex,
          onItemTapped: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
