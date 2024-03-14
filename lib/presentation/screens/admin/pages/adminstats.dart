import 'package:flutter/material.dart';

class AdminStats extends StatelessWidget {
  const AdminStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(
        child: Text('Admin Stats'),
      )),
    );
  }
}