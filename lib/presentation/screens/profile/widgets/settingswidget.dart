import 'package:flutter/material.dart';
import 'package:parkr/utils/constants.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key, required this.iconname, required this.text, this.onTap});

  final IconData iconname;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(60, 158, 158, 158)),
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconname,
                color: Colors.white,
              ),
              sizedwten(context),
              Text(
                text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15)
            ],
          ),
        ),
      ),
    );
  }
}