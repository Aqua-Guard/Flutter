import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalTextFields extends StatelessWidget {
  final String? label, hintText;
  final Icon? icon;
  final IconButton? suffixIcon;
  final bool obscureText;
  final TextEditingController? textEditingController;

  const ModalTextFields(
      {super.key,
      this.label,
      this.hintText,
      this.icon,
      required this.obscureText,
      this.suffixIcon,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: suffixIcon,
            hintText: '$hintText'),
      ),
    );
  }
}
