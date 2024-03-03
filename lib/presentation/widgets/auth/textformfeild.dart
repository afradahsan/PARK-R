import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class TFormFeild extends StatelessWidget {
  const TFormFeild({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: controller,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: greenColor),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'OTP',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter OTP';
                } else {
                  return null;
                }
              },
            );
  }
}