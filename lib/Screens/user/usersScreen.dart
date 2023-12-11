import 'dart:convert';

import 'package:aquaguard/Components/MyAppBar.dart';
import 'package:aquaguard/Models/userResponse.dart';
import 'package:aquaguard/Services/userService.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  late List<UserResponse> userArray = [];

  @override
  void initState() {
    super.initState();
    UserService().fetchUsers().then((users) {
      setState(() {
        userArray = users;
      });
    }).catchError((error) {
      print('Error getting users: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userArray != null) {
      return Scaffold(
          appBar: MyAppBar(),
          body: ListView(children: [
            Container(
                height: MediaQuery.of(context).size.height * .9,
                width: MediaQuery.of(context).size.width * .95,
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                    itemCount: userArray.length,
                    itemBuilder: (context, index) {
                      //return UserCard(userArray[index],userArray);
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 6.0,
                            shadowColor: const Color(0xff0d4f70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    radius: 80,
                                    child: ClipOval(
                                      child: Image.network(
                                        '${Constantes.imageUrl}/${userArray[index].image!}',
                                        fit: BoxFit.cover,
                                        width: MediaQuery.of(context).size.width * .45,
                                        height: MediaQuery.of(context).size.height * .45,
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        userArray[index].username!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        userArray[index].email!,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PopupMenuButton<String>(
                                      onSelected: (value) {
                                        if (value == 'delete') {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Confirm Deletion'),
                                                content: const Text('Are you sure you want to delete this user?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Response? res = await UserService().deleteUser(userArray[index].id!);
                                                      Navigator.pop(context);

                                                      if(res?.statusCode == 200)
                                                      {
                                                        print(userArray);

                                                        setState(() {
                                                          userArray.remove(userArray[index]);
                                                        });

                                                        print("---------------------------");
                                                        print(userArray);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text("Information"),
                                                              content: const Text("User successfully deleted!"),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () => Navigator.pop(context),
                                                                    child: const Text("Dismiss"))
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                      else
                                                      {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text("Error"),
                                                              content: const Text("User could not be deleted!"),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () => Navigator.pop(context),
                                                                    child: const Text("Dismiss"))
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => [
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
                        ),
                      );
                    }))
          ]));
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
