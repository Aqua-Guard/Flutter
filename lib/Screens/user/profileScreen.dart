import 'package:aquaguard/Screens/user/changePassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

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

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.grey.shade900, const Color.fromRGBO(2, 114, 255, 100)]
                : [Colors.white, const Color.fromRGBO(42, 197, 255, 100)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    size: 28, color: Colors.blue),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: FutureBuilder(
                        future: getUserDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                      AssetImage(snapshot.data!['image']!),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data!['username']!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      snapshot.data!['email']!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
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
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit profile',
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.lightBlueAccent
                                : Colors.blueAccent,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Text(
                            'Change password',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 22,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChangePassword()));
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Dark Mode',
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.lightBlueAccent
                                    : Colors.blueAccent,
                                fontSize: 22,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: isDarkMode,
                              onChanged: (value) {
                                setState(() {
                                  isDarkMode = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              'Language',
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.lightBlueAccent
                                    : Colors.blueAccent,
                                fontSize: 22,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.switch_right,
                                  size: 28, color: Colors.blueAccent),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
