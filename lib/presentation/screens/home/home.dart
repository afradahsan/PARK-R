import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/home/widgets/nearbylotcontainer.dart';
import 'package:parkr/presentation/screens/home/widgets/searchbar.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Searchbar(
              controller: searchController,
            ),
            sizedtwenty(context),
            Text(
              'Parking Lot Nearby',
              style: KTextTheme.darkTextTheme.titleMedium,
            ),
            sizedten(context),
            const NearbyLots(),
            sizedtwenty(context),
            Text(
              'Services',
              style: KTextTheme.darkTextTheme.titleMedium,
            ),
            sizedten(context),
            Container(
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
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Row(
      children: [
        Icon(
          Icons.location_on,
          color: greenColor,
          size: 18,
        ),
        sizedwfive(context),
        Text(
          'Vyttila, Ernakulam',
          style: KTextTheme.darkTextTheme.bodyLarge,
        ),
      ],
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_rounded,
            color: white,
            size: 20,
          ))
    ],
  );
}
