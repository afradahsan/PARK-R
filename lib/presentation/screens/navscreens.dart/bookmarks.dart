import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Column(children: [
        Text('BOOKMARKS')
      ],)),
    );
  }
}