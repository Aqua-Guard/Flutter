import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../Components/customButton.dart';
import '../../Components/customTextField.dart';
import '../../Services/loginService.dart';
import '../../Services/userService.dart';
import '../homeScreen.dart';
import 'loginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool containsNumber(String value) {
    return RegExp(r'[0-9]').hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color.fromRGBO(4, 157, 255, 100)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/logo.png",
                        width: MediaQuery.of(context).size.width * .8,
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
                          textEditingController: emailController,
                          label: 'Email',
                          hintText: 'Enter valid email id as example@gmail.com',
                          icon: Icon(
                            Icons.email_rounded,
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
                              blurRadius: 15,
                              offset: const Offset(0.1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: CustomTextField(
                          textEditingController: usernameController,
                          label: 'Username',
                          hintText: 'Enter a unique username',
                          icon: Icon(
                            CupertinoIcons.person_crop_circle_fill,
                            size: 40,
                            color: Colors.blue,
                          ),
                          obscureText: false,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.image, color: Color(0xff00689B)),
                          label: const Text('Select Profile Picture'),
                        ),
                        const SizedBox(width: 8),
                        if (_imageDataUrl != null)
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.1,
                            backgroundImage: _imageDataUrl != null
                                ? NetworkImage(_imageDataUrl!)
                                : null,
                            child: _imageDataUrl == null
                                ? const Icon(Icons.person,
                                size: 60, color: Colors.blue)
                                : null,
                          ),
                      ],
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
                          label: 'First Name',
                          hintText: 'Enter your first name',
                          icon: const Icon(
                            Icons.person_rounded,
                            size: 40,
                            color: Colors.blue,
                          ),
                          obscureText: false,
                          textEditingController: firstNameController,
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
                          label: 'Last Name',
                          hintText: 'Enter your last name',
                          icon: const Icon(
                            Icons.family_restroom_outlined,
                            size: 40,
                            color: Colors.blue,
                          ),
                          obscureText: false,
                          textEditingController: lastNameController,
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
                            textEditingController: passwordController,
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
                            textEditingController: confirmPasswordController,
                            label: 'Confirm Password',
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
                          text: 'Create account',
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () async {
                        if (emailController.text.isNotEmpty &&
                            usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            confirmPasswordController.text.isNotEmpty &&
                            firstNameController.text.isNotEmpty &&
                            lastNameController.text.isNotEmpty) {
                          await LoginService()
                              .signUp(
                              username: usernameController.text,
                              email: emailController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              password: passwordController.text,
                              image: _selectedImage!)
                              .then((response) async {
                            if (response?.statusCode == 201) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            } else if (response?.statusCode == 400) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Information"),
                                    content: const Text("Username already exists"),
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
                        } else if (containsNumber(firstNameController.text)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text("First name cannot contain numbers!"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Dismiss"),
                                  )
                                ],
                              );
                            },
                          );
                        } else if (containsNumber(lastNameController.text)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text("Last name cannot contain numbers!"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Dismiss"),
                                  )
                                ],
                              );
                            },
                          );
                        } else if (passwordController.text != confirmPasswordController.text) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text("Passwords have to match!"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Dismiss"))
                                ],
                              );
                            },
                          );
                        } else if (!validateEmail(emailController.text)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text("Please enter a valid email address!"),
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
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: "Already have an account yet?"),
                              TextSpan(
                                  text: ' Sign in',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
