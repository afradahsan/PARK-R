import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class OwnerRevenue extends StatelessWidget {
  const OwnerRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Revenue',
          style: TextStyle(color: greenColor, fontSize: 22)),
        backgroundColor: darkbgColor,
        elevation: 0,
      ),
      body: const SafeArea(
          child: Column(
        children: [
          
        ],
      )),
    );
  }
}