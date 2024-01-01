import 'package:aquaguard/Screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../Components/customButton.dart';
import '../../Components/modalTextFields.dart';
import '../../Services/userService.dart';

class ResetPasswordModal extends StatefulWidget {
  const ResetPasswordModal({super.key});

  @override
  State<ResetPasswordModal> createState() => _ResetPasswordModalState();
}

class _ResetPasswordModalState extends State<ResetPasswordModal> {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

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
                          child: Text(
                              "Enter the code you received below",
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
                            textEditingController: password,
                            hintText: "Password",
                            obscureText: true,
                          ),
                        ),
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
                            textEditingController: confirmPassword,
                            hintText: "Confirm Password",
                            obscureText: true,
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
                          print("--------------------------");
                          print(email);

                          if (password.text.isNotEmpty && confirmPassword.text.isNotEmpty) {
                            await UserService()
                                .forgotPassword(email!,password.text,confirmPassword.text)
                                .then((response) async {
                              if (response?.statusCode == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      LoginScreen()),
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
