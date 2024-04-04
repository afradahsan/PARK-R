import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/themes.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key, required this.text});

  final String text;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
    title: Text(
      text,
      style: KTextTheme.darkTextTheme.titleLarge,
    ),
    iconTheme: IconThemeData(color: greenColor),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
  }
}