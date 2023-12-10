import 'dart:convert';

import 'package:aquaguard/Components/MyAppBar.dart';
import 'package:aquaguard/Models/userResponse.dart';
import 'package:aquaguard/Screens/user/userCard.dart';
import 'package:aquaguard/Services/userService.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                      return UserCard(userArray[index]);
                    }))
          ]));
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
