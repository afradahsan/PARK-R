import 'package:flutter/material.dart';
import 'package:parkr/utils/constants.dart';

class BookingsContainer extends StatelessWidget {
  const BookingsContainer({super.key, required this.location, required this.time, required this.wash});

  final String location;
  final String time;
  final bool wash;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      height: 93,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Color.fromRGBO(158, 158, 158, 0.25),
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/mall-parking-image.png'),
                          fit: BoxFit.cover))),
              sizedwten(context),
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(time,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
          Positioned(
              bottom: 10,
              right: 5,
              child: wash==true ? Image.asset('assets/carwash-sponge.png'): Image.asset('assets/carwash-sponge-grayed.png'))
        ],
      ),
    );
  }
}
