import 'package:flutter/material.dart';
import 'package:lawer_finder/app/theme.dart';
import 'text.dart';

// LTD button

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.bgColor,
      this.widget,
      this.height,
      this.width,
      this.radius,
      required this.onTap,
      this.focusColor})
      : super(key: key);
  final Color? bgColor;
  final Color? focusColor;
  final Widget? widget;
  final double? height;
  final double? width;
  final double? radius;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        elevation: 0.0,
        hoverColor: focusColor,
        highlightColor: focusColor,
        color: bgColor ?? AppTheme.primaryColor,
        height: height ?? 35.0,
        minWidth: width ?? 00.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 25.0),
        ),
        onPressed: onTap,
        child: widget ??
            PText(
              text: "title",
            ));
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key,
      this.bgColor,
      this.widget,
      this.radius,
      required this.onTap,
      this.focusColor})
      : super(key: key);
  final Color? bgColor;
  final Color? focusColor;
  final Widget? widget;
  final double? radius;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: EdgeInsets.zero,
        elevation: 0.0,
        hoverColor: focusColor,
        highlightColor: focusColor,
        color: bgColor ?? AppTheme.primaryColor,
        height: radius ?? 32.0,
        minWidth: radius ?? 32.0,
        shape: const CircleBorder(),
        onPressed: onTap,
        child: widget ??
            PText(
              text: "button",
            ));
  }
}
