import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class TFormAdmin extends StatelessWidget {
  const TFormAdmin({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.textinputtype
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? textinputtype;
  // final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
            // prefixIcon: Icon(icon, color: greenColor),
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
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color.fromARGB(100, 255, 255, 255), fontSize: 14
            )),
            keyboardType: textinputtype,
        validator: validator);
  }
}
