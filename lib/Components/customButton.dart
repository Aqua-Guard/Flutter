import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? color;

  const CustomButton({super.key, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        height: MediaQuery.of(context).size.height * .08,
        width: MediaQuery.of(context).size.width * .89,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(100)),
        alignment: Alignment.center,
            child: Text(
              '$text',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
    );
  }
}
