import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/parking/choosevehicles.dart';
import 'package:parkr/utils/colors.dart';

class ParkingButton extends StatelessWidget {
  const ParkingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: greenColor,
            minimumSize: const Size(double.maxFinite, 50)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const ChooseVehicle();
            },
          ));
        },
        child: Text(
          'Book Parking',
          style: TextStyle(
              color: darkbgColor, fontSize: 18, fontWeight: FontWeight.bold),
        ));
  }
}
