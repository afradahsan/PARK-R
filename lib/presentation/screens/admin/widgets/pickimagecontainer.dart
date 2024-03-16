import 'package:flutter/material.dart';

class PickImageContainer extends StatelessWidget {
  const PickImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      height: size.height/5,
      decoration: BoxDecoration(
         border: Border.all(color: Colors.white),
         borderRadius: BorderRadius.circular(10),
        color: Colors.transparent
      ),
      child: const Icon(Icons.add_a_photo_outlined, color: Color.fromARGB(100, 255, 255, 255),),
    );
  }
}