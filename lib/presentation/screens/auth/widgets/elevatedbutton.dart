import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parkr/utils/colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.onPressed,
      required this.ButtonText,
      this.loading});

  final Function()? onPressed;
  final String ButtonText;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: greenColor,
            minimumSize: Size.fromHeight(40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: loading == false
            ? Text(
                ButtonText,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: darkbgColor),
              )
            : LoadingAnimationWidget.horizontalRotatingDots(color: darkbgColor, size: 40));
  }
}
