import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/home/widgets/services_container.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
              width: double.maxFinite,
              child: Image.asset(
                'assets/maps-sample-image.png',
                fit: BoxFit.cover,
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            height: 220,
            width: double.maxFinite,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(100, 0, 0, 0),
                  blurRadius: 2,
                  spreadRadius: 2,
                  blurStyle: BlurStyle.normal,
                ),
              ],
              color: darkbgColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: greenColor,
                    ),
                    sizedwfive(context),
                    Text(
                      'Vyttila, Ernakulam',
                      style: KTextTheme.darkTextTheme.titleMedium,
                    )
                  ],
                ),
                sizedfive(context),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServiceContainer(
                      text: 'Book a Parking Lot!',
                      image: 'assets/car-q3-parked.png',
                      imageheight: 70,
                    ),
                    ServiceContainer(
                      text: 'Let our Valet Park!',
                      image: 'assets/man-valet-park-3d.png',
                      imageheight: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 170,
              left: 185,
              child: Image.asset(
                'assets/parking-emoji.png',
                height: 20,
              )),
          Positioned(
              bottom: 70,
              left: 180,
              child: Image.asset(
                'assets/parking-emoji.png',
                height: 20,
              )),
          Positioned(
              bottom: 390,
              left: 180,
              child: Image.asset(
                'assets/parking-emoji.png',
                height: 20,
              )),
          Positioned(
              bottom: 420,
              left: 185,
              child: Image.asset(
                'assets/parking-emoji.png',
                height: 20,
              )),
          Positioned(
              bottom: 430,
              left: 160,
              child: Image.asset(
                'assets/parking-emoji.png',
                height: 20,
              )),
          Positioned(
              bottom: 295,
              right: 175,
              child: Image.asset(
                'assets/parking-emoji.png',
                height: 20,
              )),
          Positioned(
              bottom: 330,
              right: 35,
              child: Image.asset(
                'assets/parking-emoji.png',
                height: 20,
              )),
        ],
      )),
    );
  }
}
