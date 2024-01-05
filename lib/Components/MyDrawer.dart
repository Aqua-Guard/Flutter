import 'package:aquaguard/Screens/Post/allPostsScreen.dart';
import 'package:aquaguard/Screens/Post/postScreen.dart';
import 'package:aquaguard/Screens/actualite/actualiteScreen.dart';
import 'package:aquaguard/Screens/event/eventScreen.dart';
import 'package:aquaguard/Screens/reclamation/reclamationScreen.dart';
import 'package:aquaguard/Screens/event/eventStatistics.dart';
import 'package:aquaguard/Screens/homeScreen.dart';
import 'package:aquaguard/Screens/user/loginScreen.dart';
import 'package:aquaguard/Screens/user/UserStats.dart';
import 'package:flutter/material.dart';
import 'package:aquaguard/Screens/user/profileScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:aquaguard/Screens/Store/ProductListScreen.Dart';


import '../Utils/constantes.dart';

import '../Utils/constantes.dart';

class MyDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MyDrawer({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  Future<Map<String, String>> getUserDetails() async {
    final storage = FlutterSecureStorage();
    final email = await storage.read(key: 'email');
    final username = await storage.read(key: 'username');
    final image = await storage.read(key: 'image');

    return {
      'email': email ?? "",
      'username': username ?? "",
      'image': image ?? ""
    };
  }

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
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                future: getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()),
                            );
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: snapshot.data != null &&
                                snapshot.data!['image'] != null
                                ? NetworkImage(
                                '${Constantes.imageUrl}/${snapshot.data!['image']!}')
                                : null,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!['username']!,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              snapshot.data!['email']!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      'Error fetching user details',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home,
                color: selectedIndex == 0 ? Colors.white : Color(0xff00689B)),
            title: Text(
              'Home',
              style: TextStyle(
                color: selectedIndex == 0 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () async {
              onItemTapped(0);
               const storage = FlutterSecureStorage();
              var token = await storage.read(key: "token");
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  HomeScreen(token: token!)),
              );
            },
            selected: selectedIndex == 0,
            selectedTileColor: Color(0xb62aacee),
            // Background color
          ),
          ListTile(
            leading: Icon(Icons.person_rounded,
                color: selectedIndex == 1 ? Colors.white : Color(0xff00689B)),
            title: Text(
              'Users',
              style: TextStyle(
                color: selectedIndex == 1 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () {
              onItemTapped(1);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserStats()),
              );
            },
            selected: selectedIndex == 1,
            selectedTileColor: Color(0xb62aacee), // Background color
          ),
          ListTile(
            leading: Icon(Icons.event,
                color: selectedIndex == 2 ? Colors.white : Color(0xff00689B)),
            title: Text(
              'Events',
              style: TextStyle(
                color: selectedIndex == 2 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () async {
              onItemTapped(2);
              const storage = FlutterSecureStorage();
              var token = await storage.read(key: "token");
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventScreen(token: token!)),
              );
            },
            selected: selectedIndex == 2,
            selectedTileColor: Color(0xb62aacee), // Background color
          ),
          ListTile(
            leading: Icon(Icons.post_add,
                color: selectedIndex == 3 ? Colors.white : Color(0xff00689B)),
            title: Text(
              'Posts',
              style: TextStyle(
                color: selectedIndex == 3 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () async {
              onItemTapped(2);
              const storage = FlutterSecureStorage();
              var token = await storage.read(key: "token");
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllPostsScreen(token: token!)),
              );
            },
            selected: selectedIndex == 3,
            selectedTileColor: Color(0xb62aacee), // Background color
          ),
          ListTile(
            leading: Icon(Icons.store,
                color: selectedIndex == 4 ? Colors.white : Color(0xff00689B)),
            title: Text(
              'Store',
              style: TextStyle(
                color: selectedIndex == 4 ? Colors.white : Color(0xff00689B),
              ),
            ),
              onTap: () async {
              onItemTapped(4);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductListScreen()),
              );
            }
          ListTile(
            leading: Icon(Icons.report,
                color: selectedIndex == 5 ? Colors.white : Color(0xff00689B)),
            title: Text(
              'Reclamation',
              style: TextStyle(
                color: selectedIndex == 5 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () async {
              onItemTapped(5);
               const storage = FlutterSecureStorage();
              var token = await storage.read(key: "token");
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReclamationScreen(token: token!)),
              );
            },
            selected: selectedIndex == 5,
            selectedTileColor: Color(0xb62aacee), // Background color
          ),
          ListTile(
            leading: Icon(Icons.newspaper,
                color: selectedIndex == 7 ? Colors.white : Color(0xff00689B)),
            title: Text(
              'News',
              style: TextStyle(
                color: selectedIndex == 7 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () async {
              onItemTapped(7);
              const storage = FlutterSecureStorage();
              var token = await storage.read(key: "token");
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsScreen(token: token!)),
              );
            },
            selected: selectedIndex == 7,
            selectedTileColor: Color(0xb62aacee), // Background color
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.logout,
                color: selectedIndex == 6 ? Colors.white : Color(0xff00689B)),
            title: Text(
              'Logout',
              style: TextStyle(
                color: selectedIndex == 6 ? Colors.white : Color(0xff00689B),
              ),
            ),
            onTap: () async {
              onItemTapped(6);
              const storage = FlutterSecureStorage();
              await storage.delete(key: "token").then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              });
            },
            selected: selectedIndex == 6,
            selectedTileColor: Color(0xb62aacee), // Background color
          ),
        ],
      ),
    );
  }
}