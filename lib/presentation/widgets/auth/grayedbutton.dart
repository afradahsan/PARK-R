import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class GrayedButton extends StatelessWidget {
  const GrayedButton(
      {super.key, required this.onPressed, required this.ButtonText});

  final Function()? onPressed;
  final String ButtonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(199, 158, 158, 158),
            minimumSize: Size.fromHeight(40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          ButtonText,
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w600, color: darkbgColor),
        ));
  }
}
