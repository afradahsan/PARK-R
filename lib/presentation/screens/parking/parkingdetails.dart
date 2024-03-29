import 'package:flutter/material.dart';

class ParkingDetails extends StatelessWidget {
  const ParkingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [
        Container(
          height: 300,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.amber
          ),
        ),
      ],)),
    );
  }
}