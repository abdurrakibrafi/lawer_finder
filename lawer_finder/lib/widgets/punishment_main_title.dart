import 'package:flutter/material.dart';

class PunishmentMainTitle extends StatefulWidget {
  final String Title;
  final String number;

  const PunishmentMainTitle(
      {Key? key, required this.Title, required this.number})
      : super(key: key);

  @override
  State<PunishmentMainTitle> createState() => _PunishmentMainTitleState();
}

class _PunishmentMainTitleState extends State<PunishmentMainTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        widget.number,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ), //bullet text
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            widget.Title,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ), //text
      )
    ]);
  }
}
