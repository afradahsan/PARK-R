import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';

class TFormFeild extends StatelessWidget {
  const TFormFeild(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator, required this.icon, this.obscure});

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData icon;
  final bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(icon, color: greenColor),
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
              color: Colors.white,
            )),
        validator: validator, obscureText: obscure==true ? true : false,);
  }
}
