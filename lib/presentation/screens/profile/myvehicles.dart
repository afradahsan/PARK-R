import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/profile/addvehicle.dart';
import 'package:parkr/presentation/screens/profile/widgets/vehiclecontainer.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class MyVehicles extends StatelessWidget {
  const MyVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.white,),
        title: Text('Add Vehicle', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return AddVehicle();
            }));
          },
          child: Icon(
            Icons.add,
            color: darkbgColor,
          ),
          backgroundColor: greenColor),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
                        VehicleContainer(
                image: 'assets/audi-q3.png',
                modelName: 'Audi Q3',
                regNo: 'KL 11 AQ 999'),
            sizedten(context),
            VehicleContainer(
                image: 'assets/LC-prado.png',
                modelName: 'LC Prado',
                regNo: 'KL 11 N 11'),
            sizedten(context),
            VehicleContainer(
                image: 'assets/vrs_rs245.png',
                modelName: 'Octavia RS 245',
                regNo: 'KL 11 RS 245'),
                sizedten(context),
            VehicleContainer(
                image: 'assets/himalayan_411.jpg',
                modelName: 'Himalayan 411',
                regNo: 'KL 11 BZ 411'),
          ],
        ),
      )),
    );
  }
}
