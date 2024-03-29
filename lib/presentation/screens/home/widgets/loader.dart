import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, required this.appbartext});

  final String appbartext;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(appbartext, style:TextStyle(color: greenColor, fontSize: 18)),
        iconTheme: IconThemeData(color: greenColor),
        backgroundColor: darkbgColor,
        elevation: 0,
        
      ),
      body: Center(
      child: CircularProgressIndicator(color: greenColor,),
    ));
  }
}