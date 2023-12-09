import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  static final storage = GetStorage();

  // await prefs.setInt('counter', 10);

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
              padding: const EdgeInsets.only(top:8, left:8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 28,color: Colors.blue),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage("assets/images/amira.jpg"),
                        ),
                        Text(
                          "AmiraBM",
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "amira.benmbarek@esprit.tn",
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
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
                            color: isDarkMode ? Colors.lightBlueAccent : Colors.blueAccent,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Change password',
                          style: TextStyle(
                            color: isDarkMode ? Colors.lightBlueAccent : Colors.blueAccent,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Dark Mode',
                              style: TextStyle(
                                color: isDarkMode ? Colors.lightBlueAccent : Colors.blueAccent,
                                fontSize: 22,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: isDarkMode,
                              onChanged: (value) {
                                setState(() {
                                  SharedPreferences.getInstance().then((sp) {
                                    sp.setBool("isDarkMode", value);
                                  });
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
                                color: isDarkMode ? Colors.lightBlueAccent : Colors.blueAccent,
                                fontSize: 22,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.switch_right, size: 28,color: Colors.blueAccent),
                              onPressed: () {

                              },
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