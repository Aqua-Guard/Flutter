import 'package:aquaguard/Screens/user/profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../Components/customButton.dart';
import '../../Components/regularTextField.dart';
import '../../Services/userService.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isPasswordVisible2 = true;
  bool _isPasswordVisible3 = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, const Color.fromRGBO(42, 197, 255, 100)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  child: RegularTextField(
                    label: 'Old Password',
                    textEditingController: oldPasswordController,
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
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                  child: RegularTextField(
                    label: 'New Password',
                    textEditingController: newPasswordController,
                    obscureText: _isPasswordVisible2,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible2 = !_isPasswordVisible2;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.blue,
                          size: 32,
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                  child: RegularTextField(
                    label: 'Confirm Password',
                    textEditingController: confirmPasswordController,
                    obscureText: _isPasswordVisible3,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible3 = !_isPasswordVisible3;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible3
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.blue,
                          size: 32,
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    var email = await storage.read(key: "email");

                    if (oldPasswordController.text.isNotEmpty &&
                        newPasswordController.text.isNotEmpty &&
                        confirmPasswordController.text.isNotEmpty) {
                      await UserService()
                          .changePassword(email!, oldPasswordController.text,
                          newPasswordController.text,
                          confirmPasswordController.text)
                          .then((response) async {
                        if (response?.statusCode == 200) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen()),
                          );
                        } else if (response?.statusCode == 400) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Information"),
                                content: const Text("Passwords don't match!"),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: const Text("Dismiss"))
                                ],
                              );
                            },
                          );
                        } else if (response?.statusCode == 500) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Information"),
                                content: const Text("Please recheck your old password!"),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
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
                                const Text("Sorry! Try again later"),
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
                  }

              ),

            ],
          ),
        ),
      ),
    );
  }
}
