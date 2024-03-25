import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkr/utils/colors.dart';

class kButtonTheme{
  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
                style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(TextStyle(color: greenColor, fontFamily: GoogleFonts.montserrat().fontFamily)),
                  foregroundColor: MaterialStatePropertyAll(greenColor),
                  backgroundColor: MaterialStatePropertyAll(darkbgColor),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(10))))
                );
}