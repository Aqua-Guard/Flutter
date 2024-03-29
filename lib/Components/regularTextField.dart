import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegularTextField extends StatelessWidget {
  final String? label;
  final IconButton? suffixIcon;
  final bool obscureText;
  final TextEditingController? textEditingController;

  const RegularTextField(
      {super.key,
        this.label,
        required this.obscureText,
        this.suffixIcon,
        this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35),

          child: TextField(
              controller: textEditingController,
              obscureText: obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: suffixIcon,
                label: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('$label')),
              )),
        ));
  }
}
