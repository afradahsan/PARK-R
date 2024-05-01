import 'package:flutter/material.dart';
import 'package:parkr/utils/themes.dart';

class TicketTest extends StatelessWidget {
  const TicketTest({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.black54),
        ),
        Text(
          content,
          style: KTextTheme.lightTextTheme.titleLarge,
        ),
      ],
    );
  }
}
