import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/profile/widgets/vehiclecontainer.dart';
import 'package:parkr/utils/constants.dart';

class MyVehicles extends StatelessWidget {
  const MyVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back, color: Colors.white, size: 20,),
                Text(
                  'My Vehicles',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            sizedten(context),
            VehicleContainer(image: 'assets/audi-q3.png', modelName: 'Audi Q3', regNo: 'KL 11 AQ 999'),
            sizedten(context),
            VehicleContainer(image: 'assets/LC-prado.png', modelName: 'LC Prado', regNo: 'KL 11 N 11'),
            sizedten(context),
            VehicleContainer(image: 'assets/vrs_rs245.png', modelName: 'Octavia RS 245', regNo: 'KL 11 RS 245'),
          ],
        ),
      )),
    );
  }
}
