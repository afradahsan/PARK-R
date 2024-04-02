import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/themes.dart';

class ChooseVehicle extends StatelessWidget {
  const ChooseVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details', style: KTextTheme.darkTextTheme.titleLarge,
        ),
        iconTheme: IconThemeData(color: greenColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose your Vehicle:', style: KTextTheme.darkTextTheme.titleLarge,),
            
          ],
        ),
      )),
    );
  }
}
