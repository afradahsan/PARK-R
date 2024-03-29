import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/home/parkinglots.dart';

class ServiceContainer extends StatelessWidget {
  const ServiceContainer({super.key, required this.text, required this.image, required this.imageheight});

  final String  text;
  final String image;
  final double imageheight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){ return const ParkingLots();}));
      },
      child: Container(
        height: 140,
        width: 150,
        decoration: BoxDecoration(
            color: const Color.fromARGB(30, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            border: const Border(
              top: BorderSide(width: 1, color: Colors.white),
              bottom: BorderSide(width: 1, color: Colors.white),
              left: BorderSide(width: 1, color: Colors.white),
              right: BorderSide(width: 1, color: Colors.white),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(100, 0, 0, 0),
                blurRadius: 2,
                spreadRadius: 2,
                blurStyle: BlurStyle.normal,
              )
            ]),
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Stack(
          children: [
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  image,
                  height: imageheight,
                ))
          ],
        ),
      ),
    );
  }
}
