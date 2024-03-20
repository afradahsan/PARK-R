import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Parking Lots near you!', style:TextStyle(color: greenColor, fontSize: 18)),
        iconTheme: IconThemeData(color: greenColor),
        backgroundColor: darkbgColor,
        elevation: 0,
        actions: [
          Icon(Icons.search)
        ],
      ),
      body: Center(
      child: CircularProgressIndicator(color: greenColor,),
    ));
  }
}