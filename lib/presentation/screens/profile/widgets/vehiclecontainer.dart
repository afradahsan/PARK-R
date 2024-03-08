import 'package:flutter/material.dart';
import 'package:parkr/utils/constants.dart';

class VehicleContainer extends StatelessWidget {
  const VehicleContainer({super.key, required this.image, required this.modelName, required this.regNo});

  final String image;
  final String modelName;
  final String regNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(105, 158, 158, 158)),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(image, height: 40)),
            sizedwten(context),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modelName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Text(regNo,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
