import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/home/parkinglots.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/themes.dart';

class BookParkingContainer extends StatelessWidget {
  const BookParkingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ParkingLots();
                    },
                  ));
                },
                child: Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: whitet150),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_parking,
                        size: 40,
                        color: white,
                      ),
                      Text(
                        'Book a Parking',
                        style: KTextTheme.darkTextTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              );
  }
}