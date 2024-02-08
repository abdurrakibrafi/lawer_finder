// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class CustomRichText extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomRichText({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> words = subtitle.split(' ');
    String truncatedSubtitle =
    words.length <= 4 ? subtitle : '${words.sublist(0, 5).join(' ')}...';
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: truncatedSubtitle,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}