import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class NearbyLots extends StatelessWidget {
  const NearbyLots({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Parking Lot Nearby',
          style: KTextTheme.darkTextTheme.titleMedium,
        ),
        sizedten(context),
        Stack(
          children: [
            Container(
              height: 200,
              width: screenW(context) - 100,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/mall-parking-image.png'),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 7)
                  ],
                  color: whitet50,
                  borderRadius: BorderRadius.circular(15)),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: screenW(context) - 100,
                height: 90,
                decoration: BoxDecoration(
                    color: darkbgColor,
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lulu Mall Parking',
                        style: KTextTheme.darkTextTheme.bodyLarge,
                      ),
                      Text(
                        'Edappally',
                        style: TextStyle(color: whitet150, fontSize: 12),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.location_fill,
                                size: 15,
                                color: whitet200,
                              ),
                              sizedwfive(context),
                              Text('0.6KM')
                            ],
                          ),
                          const Spacer(),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '₹10',
                                style: TextStyle(
                                    color: greenColor,
                                    fontSize: 16,
                                    fontFamily:
                                        GoogleFonts.montserrat().fontFamily)),
                            TextSpan(
                                text: '/hr',
                                style: TextStyle(
                                    color: whitet150,
                                    fontSize: 12,
                                    fontFamily:
                                        GoogleFonts.montserrat().fontFamily))
                          ]))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
