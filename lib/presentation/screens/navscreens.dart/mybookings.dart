import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/widgets/home/bookings_container.dart';
import 'package:parkr/utils/constants.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('My Bookings', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
            ],
          ),
          sizedtwenty(context),
          BookingsContainer(location: 'Lulu Mall Parking', time: '3PM to 6PM', wash: true),
          sizedten(context),
          BookingsContainer(location: 'Marine Drive Parking', time: '8PM to 12PM', wash: false),
        ],),
      )),
    );
  }
}