import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Column(children: [
        Text('MY BOOKINGS')
      ],)),
    );
  }
}