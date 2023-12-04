import 'package:aquaguard/Screens/homeScreen.dart';
import 'package:aquaguard/Screens/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Components/customButton.dart';
import '../Components/customTextField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}
class RegisterScreenState extends State<RegisterScreen>{
  bool _isPasswordVisible = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  "assets/login_background.png",
                  fit: BoxFit.cover,
                ),
              ),
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
                      child: const CustomTextField(
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
                      child: const CustomTextField(
                        label: 'Username',
                        hintText: 'Enter a unique username',
                        icon: Icon(
                          Icons.person_rounded,
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
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.blue,
                                size: 32,
                              )
                          ),
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
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
                            TextSpan(text: "Already have an account yet ?"),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              )

            ],
          ),
        )
    );
  }
}
