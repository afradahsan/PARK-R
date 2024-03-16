import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(SnackBar(content: Text(text)));
}