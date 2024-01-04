import 'dart:convert';

import 'package:aquaguard/Components/customButton.dart';
import 'package:aquaguard/Screens/user/codeModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../Components/customTextField.dart';
import '../../Components/modalTextFields.dart';
import '../../Services/userService.dart';

class EmailModal extends StatefulWidget {
  const EmailModal({super.key});

  @override
  State<EmailModal> createState() => _EmailModalState();
}

class _EmailModalState extends State<EmailModal> {
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: 8.5,
              width: 85,
            ),
            Container(
                margin: const EdgeInsets.all(35),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Reset Password",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.left)),
                    SizedBox(
                      height: 14,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Enter your email below to receive a code",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left)),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
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
                        child: ModalTextFields(
                          textEditingController: email,
                          hintText: 'Enter valid email as example@gmail.com',
                          obscureText: false,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    GestureDetector(
                      child: const CustomButton(
                        color: Colors.blue,
                        text: "Send Email",
                      ),
                      onTap: () async {
                        if (email.text.isNotEmpty) {
                          await UserService()
                              .sendCode(email.text)
                              .then((response) async {
                                print(response?.body);
                            if (response?.statusCode == 200) {
                              const storage = FlutterSecureStorage();
                              await storage.write(
                                  key: "resetEmail", value: email.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CodeModal()),
                              );
                            } else if (response?.statusCode == 400) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Information"),
                                    content: const Text("Email not found!"),
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
                                        const Text("Error! Try again later"),
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
                      },
                    )
                  ],
                )),
            SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
