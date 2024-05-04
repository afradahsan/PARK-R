import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String uri = 'https://parkwiser.ddns.net';

String formatTime(String timeString) {
  final List<String> parts =
      timeString.replaceAll(')', '').split('(')[1].split(':');
  final int hour = int.parse(parts[0]);
  final int minute = int.parse(parts[1]);
  TimeOfDay time = TimeOfDay(hour: hour, minute: minute);
  final DateTime dateTime = DateTime(2024, 1, 1, time.hour, time.minute);
  return DateFormat('h:mm a').format(dateTime);
}

SizedBox sizedten(BuildContext ctx) {
  return SizedBox(
    height: (MediaQuery.of(ctx).size.height) / 80,
  );
}

SizedBox sizedfive(BuildContext ctx) {
  return SizedBox(
    height: (MediaQuery.of(ctx).size.height) / 160,
  );
}

SizedBox sizedtwenty(BuildContext ctx) {
  return SizedBox(
    height: (MediaQuery.of(ctx).size.height) / 40,
  );
}

SizedBox sizedwten(BuildContext ctx) {
  return SizedBox(
    width: (MediaQuery.of(ctx).size.height) / 80,
  );
}

SizedBox sizedwfive(BuildContext ctx) {
  return SizedBox(
    width: (MediaQuery.of(ctx).size.height) / 160,
  );
}

BorderRadius kBordRadius(double num) {
  return BorderRadius.circular(num);
}

double screenW(BuildContext ctx) {
  return MediaQuery.of(ctx).size.height;
}
