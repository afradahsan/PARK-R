import 'package:flutter/material.dart';

class AdminPark extends StatelessWidget {
  const AdminPark({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(
        child: Text('Admin Park'),
      )),
    );
  }
}