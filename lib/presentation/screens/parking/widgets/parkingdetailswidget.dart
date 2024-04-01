import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class ParkingDWidget extends StatelessWidget {
  const ParkingDWidget(
      {super.key, required this.parkinglist, required this.index});

  final List<ParkingModel> parkinglist;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mainImage(parkinglist, index),
          sizedtwenty(context),
          mainTitle(parkinglist, index),
          sizedtwenty(context),
          
        ],
      ),
    );
  }
}

Widget mainImage(List<ParkingModel> parkinglist, int index) {
  return Stack(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 220,
            width: double.maxFinite,
            child: Image.network(
              parkinglist[0].image,
              fit: BoxFit.cover,
            ),
          )),
      const Positioned(
          top: 10,
          left: 10,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ))
    ],
  );
}

Widget mainTitle(List<ParkingModel> parkinglist, int index) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parkinglist[index].parkingName,
            style: KTextTheme.darkTextTheme.titleLarge,
          ),
          Text(parkinglist[index].locationName,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(150, 255, 255, 255)))
        ],
      ),
      const Spacer(),
      Icon(
        Icons.favorite_border_rounded,
        color: greenColor,
      )
    ],
  );
}

