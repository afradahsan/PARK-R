import 'package:flutter/material.dart';
import 'package:parkr/presentation/widgets/home/services_container.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                    Text('Vyttila, Ernakulam', style: KTextTheme.darkTextTheme.titleMedium,)
                  ],
                ),
                sizedfive(context),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServiceContainer(text: 'Let our Valet Park!', image: 'assets/man-valet-park-3d.png', imageheight: 100,),
                    ServiceContainer(text: 'Book a Parking Lot!', image: 'assets/car-q3-parked.png', imageheight: 70,),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
