import 'package:flutter/material.dart';

class BulletText extends StatefulWidget {
  final String Title;
  const BulletText({Key? key, required this.Title}) : super(key: key);

  @override
  State<BulletText> createState() => _BulletTextState();
}

class _BulletTextState extends State<BulletText> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "\u2022",
        style: TextStyle(fontSize: 30, color: Colors.white),
      ), //bullet text
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.Title,
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
        ), //text
      )
    ]);
  }
}
