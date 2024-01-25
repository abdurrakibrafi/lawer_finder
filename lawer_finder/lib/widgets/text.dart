// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawer_finder/app/theme.dart';

class PText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;

  final String? fontFamily;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? wordSpacing;
  final double? letterSpacing;

  final TextDirection? textDirection;
  final TextDecoration? decoration;
  TextOverflow? overflow;
  Paint? foreground;
  FontStyle? fontStyle;
  PText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.maxLines,
    this.fontWeight,
    this.textAlign,
    this.wordSpacing,
    this.letterSpacing,
    this.textDirection,
    this.decoration,
    this.overflow,
    this.foreground,
    this.fontStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('$text',
        style: GoogleFonts.poppins(
          decoration: decoration,
          fontSize: fontSize ?? 15.0,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? AppTheme.blackColor,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
          foreground: foreground,
          fontStyle: fontStyle,
        ),
        maxLines: maxLines ?? 1,
        textAlign: textAlign ?? TextAlign.center,
        textDirection: textDirection ?? TextDirection.ltr,
        overflow: TextOverflow.ellipsis);
  }
}
