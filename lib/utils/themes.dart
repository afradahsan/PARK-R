import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class KTextTheme {
  KTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
  );


  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: greenColor),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: greenColor),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: greenColor),
    titleLarge: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: greenColor),
    titleMedium: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: greenColor),
    titleSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: greenColor),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: greenColor),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: greenColor),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: greenColor),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.w600, color: greenColor),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: greenColor),
  );

  static TextTheme darkwhiteTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: white),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: white),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: white),
    titleLarge: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: white),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: white),
    titleSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: white),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: white),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: white),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: white),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: white),
    labelMedium: const TextStyle().copyWith(
        fontSize: 10.0, fontWeight: FontWeight.normal, color: whitet200),
  );
}
