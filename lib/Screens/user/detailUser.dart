import 'package:aquaguard/Models/userResponse.dart';
import 'package:aquaguard/Screens/user/usersScreen.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../Services/userService.dart';

class DetailUser extends StatefulWidget {
  final UserResponse user;

  const DetailUser({super.key, required this.user});

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details',
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${Constantes.imageUrl}/${widget.user.image}'),
                          radius: 80,
                        ),
                        const SizedBox(height: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Icon(
                                //   Icons.account_circle,
                                //   color: Colors.blue,
                                //   size: 26,
                                // ),
                                // const SizedBox(width: 10),
                                Text(
                                  widget.user.username!,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 10),
                                Text(widget.user.email!),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.person_rounded,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                    ' ${widget.user.firstName} ${widget.user.firstName}'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.currency_bitcoin_rounded,
                                  color: Colors.blue,
                                ),
                                Text(widget.user.nbPts.toString()),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.user.role != "admin")
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              Response? res =
                              await UserService().banUser(widget.user.id!);
                              // Navigator.pop(context);

                              if (res?.statusCode == 200) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Information"),
                                      content: const Text(
                                          "User successfully banned!"),
                                      actions: [
                                        TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text("Dismiss"))
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          "User could not be banned!"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Dismiss"))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            icon: const Icon(Icons.block, color: Colors.red),
                            label: const Text('Ban', style: TextStyle(
                                color: Colors.red
                            ),),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.blue.shade100,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
