import 'dart:convert';

import 'package:aquaguard/Components/customTextField.dart';
import 'package:aquaguard/Screens/user/resetPasswordModal.dart';
import 'package:aquaguard/Services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../Components/customButton.dart';
import '../../Components/modalTextFields.dart';

class CodeModal extends StatefulWidget {
  const CodeModal({Key? key}) : super(key: key);

  @override
  State<CodeModal> createState() => _CodeModalState();
}

class _CodeModalState extends State<CodeModal> {
  final TextEditingController code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
                      const Align(
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
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text("Enter the code you received below",
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
                            textEditingController: code,
                            hintText: '',
                            obscureText: false,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      GestureDetector(
                        child: CustomButton(
                          color: Colors.blue,
                          text: "Verify Password",
                        ),
                        onTap: () async {
                          const storage = FlutterSecureStorage();
                          var email = await storage.read(key: "resetEmail");

                          if (code.text.isNotEmpty) {
                            await UserService()
                                .verifyCode(email!, code.text)
                                .then((response) async {
                              if (response?.statusCode == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPasswordModal()),
                                );
                              } else if (response?.statusCode == 400) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Information"),
                                      content: const Text("Wrong code!"),
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
                height: 300,
              )
            ],
          ),
        ),
      ),
    );
  }
}
