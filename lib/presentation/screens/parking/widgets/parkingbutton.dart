import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/parking/choosevehicles.dart';
import 'package:parkr/utils/colors.dart';

class ParkingButton extends StatelessWidget {
  const ParkingButton({super.key, required this.text, required this.onpressed});

  final String text;
  final void Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: greenColor,
            minimumSize: const Size(double.maxFinite, 50)),
        onPressed: 
          onpressed,
        child: Text(
          text,
          style: TextStyle(
              color: darkbgColor, fontSize: 18, fontWeight: FontWeight.bold),
        ));
  }
}
