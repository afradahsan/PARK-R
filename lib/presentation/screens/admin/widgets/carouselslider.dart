import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatelessWidget {
  const CarouselImages({super.key, required this.images});

  final List images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Stack(
              children: [
                Image.file(
                  i,
                  fit: BoxFit.cover,
                  height: 200,
                ),
                Positioned(
                  left: 70,
                  top: 90,
                  child: Icon(Icons.add_a_photo, color: const Color.fromARGB(100, 255, 255, 255),))
              ],
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}