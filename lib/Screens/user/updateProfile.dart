import 'dart:convert';
import 'dart:html';

import 'package:aquaguard/Components/regularTextField.dart';
import 'package:aquaguard/Screens/user/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:html' as html;

import '../../Components/customButton.dart';
import '../../Components/customTextField.dart';
import '../../Services/loginService.dart';
import '../../Services/userService.dart';
import '../../Utils/constantes.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

Future<Map<String, String>> getUserDetails() async {
  final storage = FlutterSecureStorage();
  final email = await storage.read(key: 'email');
  final username = await storage.read(key: 'username');
  final image = await storage.read(key: 'image');
  final firstName = await storage.read(key: 'firstName');
  final lastName = await storage.read(key: 'lastName');

  return {
    'email': email ?? "",
    'username': username ?? "",
    'image': image ?? "",
    'firstName': firstName ?? "",
    'lastName': lastName ?? ""
  };
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  html.File? _selectedImage;
  String? _imageDataUrl;

  Future<void> _pickImage() async {
    final filePicker = html.FileUploadInputElement()..accept = 'image/*';
    filePicker.click();

    filePicker.onChange.listen((event) {
      final file = filePicker.files!.first;
      final reader = html.FileReader();

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((loadEndEvent) {
        setState(() {
          _selectedImage = file;
          _imageDataUrl = reader.result as String;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color.fromRGBO(4, 157, 255, 100)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: FutureBuilder(
                    future: getUserDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        emailController.text = snapshot.data!['email']!;
                        usernameController.text = snapshot.data!['username']!;
                        firstNameController.text = snapshot.data!['firstName']!;
                        lastNameController.text = snapshot.data!['lastName']!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .3,
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  child: Column(
                                    children: [
                                      if (_imageDataUrl != null ||
                                          snapshot.data!['image'] != null)
                                        CircleAvatar(
                                          radius: _imageDataUrl != null
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1
                                              : 70,
                                          backgroundImage: _imageDataUrl != null
                                              ? NetworkImage(_imageDataUrl!)
                                              : snapshot.data!['image'] !=
                                                          null &&
                                                      snapshot.data!['image']
                                                          is String
                                                  ? NetworkImage(
                                                      '${Constantes.imageUrl}/${snapshot.data!['image']}')
                                              : null,
                                child: _imageDataUrl == null &&
                                    snapshot.data!['image'] ==
                                        null
                                    ? const Icon(Icons.person,
                                    size:  60, color: Colors.blue)
                                    : null,
                                ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: _pickImage,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue[200],
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black45.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 15,
                                            offset: const Offset(0.1, 1),
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: RegularTextField(
                                        textEditingController:
                                            usernameController,
                                        label: 'Username',
                                        obscureText: false,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black45.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 15,
                                            offset: const Offset(0.1, 1),
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: RegularTextField(
                                        textEditingController: emailController,
                                        label: 'Email',
                                        obscureText: false,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black45.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 15,
                                            offset: const Offset(0.1, 1),
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: RegularTextField(
                                        textEditingController:
                                            firstNameController,
                                        label: 'First Name',
                                        obscureText: false,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black45.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 15,
                                            offset: const Offset(0.1, 1),
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: RegularTextField(
                                        textEditingController:
                                            lastNameController,
                                        label: 'Last Name',
                                        obscureText: false,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  GestureDetector(
                                      child: const Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: CustomButton(
                                          text: 'Confirm',
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onTap: () async {
                                        const storage = FlutterSecureStorage();
                                        var id = await storage.read(key: "id");
                                        String? imagePath = await storage.read(key: "image");

                                        if (_selectedImage == null) {
                                          final html.HttpRequest request = html.HttpRequest();
                                          request.open('GET', imagePath!);
                                          request.responseType = 'blob';
                                          request.onLoad.listen((html.Event e) {
                                            final blob = request.response as html.Blob;
                                            _selectedImage = html.File([blob], 'filename.jpg');
                                          });
                                          request.send();
                                        }

                                        if (emailController.text.isNotEmpty &&
                                            usernameController
                                                .text.isNotEmpty &&
                                            firstNameController
                                                .text.isNotEmpty &&
                                            lastNameController
                                                .text.isNotEmpty) {
                                          await LoginService()
                                              .updateProfile(
                                                  id: id!,
                                                  username:
                                                      usernameController.text,
                                                  email: emailController.text,
                                                  firstName:
                                                      firstNameController.text,
                                                  lastName:
                                                      lastNameController.text,
                                              image: _selectedImage!)
                                              .then((response) async {
                                            if (response?.statusCode == 200) {
                                              final responseData = json.decode(response!.body);
                                              // const storage = FlutterSecureStorage();
                                              await storage.write(
                                                  key: "email", value: responseData['email']);
                                              await storage.write(
                                                  key: "username", value: responseData['username']);
                                              await storage.write(
                                                  key: "image", value: responseData['image']);
                                              await storage.write(
                                                  key: "firstName", value: responseData['firstName']);
                                              await storage.write(
                                                  key: "lastName", value: responseData['lastName']);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen()),
                                              );
                                            } else if (response?.statusCode ==
                                                500) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Information"),
                                                    content: const Text(
                                                        "Server issue!"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: const Text(
                                                              "Dismiss"))
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Information"),
                                                    content: const Text(
                                                        "Sorry! Try again later"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: const Text(
                                                              "Dismiss"))
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          });
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Error"),
                                                content: const Text(
                                                    "Fields can't be empty!"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text("Dismiss"))
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      }),
                                ],
                              ),
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
            ],
          ),
        ));
  }
}
