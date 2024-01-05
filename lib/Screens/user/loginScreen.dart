import 'dart:convert';

import 'package:aquaguard/Screens/user/codeModal.dart';
import 'package:aquaguard/Screens/user/emailModal.dart';
import 'package:aquaguard/Screens/user/resetPasswordModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../Components/customButton.dart';
import '../../Components/customTextField.dart';
import '../../Services/loginService.dart';
import 'package:aquaguard/Screens/user/registerScreen.dart';
import '../homeScreen.dart';
import './userStats.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = true;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login_background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.width * .8,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: const Offset(0.1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: CustomTextField(
                      textEditingController: _username,
                      label: 'Username',
                      hintText: 'Please enter your username',
                      icon: const Icon(
                        CupertinoIcons.person_crop_circle_fill,
                        size: 40,
                        color: Colors.blue,
                      ),
                      obscureText: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: CustomTextField(
                        textEditingController: _password,
                        label: 'Password',
                        hintText:
                        'Enter secure password between 6 and 8 characters',
                        icon: const Icon(Icons.lock_rounded,
                            size: 40, color: Colors.blue),
                        obscureText: _isPasswordVisible,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blue,
                              size: 32,
                            )),
                      )),
                ),
                GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: CustomButton(
                      text: 'Login',
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () async {
                    if (_username.text.isNotEmpty &&
                        _password.text.isNotEmpty) {
                      await LoginService()
                          .login(context, _username.text, _password.text)
                          .then((response) async {
                        if (response?.statusCode == 200) {
                          final responseData = json.decode(response!.body);
                          const storage = FlutterSecureStorage();
                          await storage.write(
                              key: "token", value: responseData['token']);
                          await storage.write(
                              key: "email", value: responseData['email']);
                          await storage.write(
                              key: "id", value: responseData['id']);
                          await storage.write(
                              key: "username", value: responseData['username']);
                          await storage.write(
                              key: "image", value: responseData['image']);
                          await storage.write(
                              key: "firstName", value: responseData['firstName']);
                          await storage.write(
                              key: "lastName", value: responseData['lastName']);
                          await storage.write(
                              key: "nbPts",
                              value: responseData['nbPts'].toString());
                          var token = await storage.read(key: "token");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(token: token!,)),
                          );
                        } else if (response?.statusCode == 403) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text(
                                    "Access Denied. Only admin can login!"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Dismiss"))
                                ],
                              );
                            },
                          );
                        } else if (response?.statusCode == 400) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Information"),
                                content:
                                const Text("wrong username or password!"),
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
                                title: const Text("Information"),
                                content:
                                const Text("Server error! Try again later"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Dismiss"))
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
                            content: const Text("Fields can't be empty!"),
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
                ),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  onTap: () => showModalBottomSheet(
                      context: context, builder: (context) => EmailModal()),
                ),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: "Don't have an account yet ?"),
                            TextSpan(
                                text: ' Sign up',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterScreen()));
                  },
                ),
              ],
            )));
  }
}
