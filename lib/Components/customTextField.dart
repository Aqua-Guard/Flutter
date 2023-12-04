import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  final String? label, hintText;
  final Icon? icon;
  final IconButton? suffixIcon;
  final bool obscureText;
  const CustomTextField({super.key, this.label, this.hintText, this.icon, required this.obscureText, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Container(
                height: MediaQuery.of(context).size.height * .09,
                width: MediaQuery.of(context).size.width * .2,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 15,
                        offset: const Offset(0.1, 0.1),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: icon
            ),
            suffixIcon: suffixIcon,
            label: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text('$label')),
            hintText:
            '$hintText'),
      ),
    );
  }
}
