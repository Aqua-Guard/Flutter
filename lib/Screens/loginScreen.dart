import 'package:aquaguard/Screens/RegisterScreen.dart';
import 'package:aquaguard/Screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Components/customButton.dart';
import '../Components/customTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}
class LoginScreenState extends State<LoginScreen>{
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
                      text: 'Login',
                      color: Colors.blue,

                      ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
                  },
                ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Forgot password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,

                            ),
                          ),
                        ],
                      ),
                    ),
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterScreen()));
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
