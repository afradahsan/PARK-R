import 'package:flutter/material.dart';

String uri = 'http://192.168.155.182:3000';

SizedBox sizedten(BuildContext ctx) {
  return SizedBox(height: (MediaQuery.of(ctx).size.height)/80,);
}

SizedBox sizedfive(BuildContext ctx) {
  return SizedBox(height: (MediaQuery.of(ctx).size.height)/160,);
}

SizedBox sizedtwenty(BuildContext ctx) {
  return SizedBox(height: (MediaQuery.of(ctx).size.height)/40,);
}
SizedBox sizedwten(BuildContext ctx) {
  return SizedBox(width: (MediaQuery.of(ctx).size.height)/80,);
}
SizedBox sizedwfive(BuildContext ctx) {
  return SizedBox(width: (MediaQuery.of(ctx).size.height)/160,);
}
BorderRadius kBordRadius(double num){
  return BorderRadius.circular(num);
}
double screenW(BuildContext ctx){
  return MediaQuery.of(ctx).size.height;
}