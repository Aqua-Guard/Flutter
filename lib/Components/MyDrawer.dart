import 'package:aquaguard/Screens/Post/postScreen.dart';
import 'package:aquaguard/Screens/event/eventStatistics.dart';
import 'package:aquaguard/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:aquaguard/Screens/profileScreen.dart';

class MyDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MyDrawer({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/nav_header.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/malek.jpg"),
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Malek Labidi",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "labidi.malek@esprit.tn",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            
            leading:  Icon(Icons.home, color: selectedIndex == 0 ? Colors.white : Color(0xff00689B)),
            title:  Text(
              'Home',
              style: TextStyle(
                color: selectedIndex == 0 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () {
                onItemTapped(0);
              Navigator.pop(context);
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            selected: selectedIndex == 0,
            selectedTileColor: Color(0xff00689B),
             // Background color
          ),
          ListTile(
            leading:  Icon(Icons.person_rounded, color: selectedIndex == 1 ? Colors.white : Color(0xff00689B)),
            title:  Text(
              'Users',
              style: TextStyle(
                color: selectedIndex == 1 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () {
                onItemTapped(1);
              Navigator.pop(context);
            },
            selected: selectedIndex == 1,
            selectedTileColor: Color(0xff00689B), // Background color
          ),
          ListTile(
            leading:  Icon(Icons.event, color: selectedIndex == 2 ? Colors.white : Color(0xff00689B)),
            title:  Text(
              'Events',
              style: TextStyle(
                color: selectedIndex == 2 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () {
                onItemTapped(2);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventStatistics()),
              );
            },
            selected: selectedIndex == 2,
            selectedTileColor: Color(0xff00689B), // Background color
          ),
          ListTile(
            leading:  Icon(Icons.post_add, color: selectedIndex == 3 ? Colors.white : Color(0xff00689B)),
            title:  Text(
              'Posts',
              style: TextStyle(
                color: selectedIndex == 3 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () {
                onItemTapped(3);
              Navigator.pop(context);
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PostScreen()),
              );
            },
            selected: selectedIndex == 3,
            selectedTileColor: Color(0xff00689B), // Background color
          ),
          ListTile(
            leading:  Icon(Icons.store, color: selectedIndex == 4 ? Colors.white : Color(0xff00689B)),
            title:  Text(
              'Store',
              style: TextStyle(
                color: selectedIndex == 4 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () {
                onItemTapped(4);
              Navigator.pop(context);
            },
            selected: selectedIndex == 4,
            selectedTileColor: Color(0xff00689B), // Background color
          ),
          ListTile(
            leading:  Icon(Icons.report, color: selectedIndex == 5 ? Colors.white : Color(0xff00689B)),
            title:  Text(
              'Reclamation',
              style: TextStyle(
                color: selectedIndex == 5 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () {
                onItemTapped(5);
              Navigator.pop(context);
            },
            selected: selectedIndex == 5,
            selectedTileColor: Color(0xff00689B), // Background color
          ),
          const Divider(),
          ListTile(
            leading:  Icon(Icons.logout, color: selectedIndex == 6 ? Colors.white : Color(0xff00689B)),
            title:  Text(
              'Logout',
              style: TextStyle(
                color: selectedIndex == 6 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () {
                onItemTapped(6);
              Navigator.pop(context);
            },
            selected: selectedIndex == 6,
            selectedTileColor: Color(0xff00689B), // Background color
          ),
        ],
      ),
    );
  }

 
 
}
