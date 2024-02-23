import 'package:flutter/material.dart';

class SuggestionText extends StatefulWidget {
  final String Title;

  const SuggestionText({Key? key, required this.Title}) : super(key: key);

  @override
  State<SuggestionText> createState() => SuggestionTextState();
}

class SuggestionTextState extends State<SuggestionText> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "👉",
        style: TextStyle(fontSize: 25, color: Colors.white),
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
