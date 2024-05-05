import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class AnimatedVeh extends StatefulWidget {
  const AnimatedVeh({super.key});

  @override
  State<AnimatedVeh> createState() => _AnimatedVehState();
}

class _AnimatedVehState extends State<AnimatedVeh> {

  double height = 40;
  double width = 58;
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {setState(() {
        tapped = !tapped;
        tapped ? height += 40 : height = height;
        tapped = true;
        debugPrint('statement');
      });},
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: whitet200),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.drive_eta,
                  color: greenColor,
                  size: 18,
                ),
                Icon(
                  CupertinoIcons.chevron_down,
                  color: whitet150,
                  size: 18,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
