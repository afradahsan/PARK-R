import 'package:flutter/material.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/themes.dart';

class IncludeWash extends StatefulWidget {
  const IncludeWash({super.key});

  @override
  State<IncludeWash> createState() => _IncludeWashState();
}

class _IncludeWashState extends State<IncludeWash> {

  bool wash = false;
  
  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Include Washing',
            style: KTextTheme.darkwhiteTextTheme.titleMedium,
          ),
          Text(
            'Price ranges between ₹299 to ₹499',
            style: KTextTheme.darkwhiteTextTheme.labelMedium,
          )
        ],
      ),
      const Spacer(),
      IconButton(
        onPressed: (){
          setState(() {
            wash = !wash;
          });
        },
        icon: wash ? Icon(
          Icons.toggle_on,
          color: greenColor,
          size: 40,
        ) : const Icon(Icons.toggle_off, color: Colors.grey, size: 40,)
      )
    ],
  );
  }
}