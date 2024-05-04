import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Searchbar(
              controller: searchController,
            ),
            Text('Services'),
            
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
