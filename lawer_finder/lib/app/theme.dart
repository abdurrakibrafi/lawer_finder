import 'package:flutter/material.dart';
import 'package:lawer_finder/utils/text/text.dart';

class AppTheme {
  static const Color primaryColor = Color(0xff4C5D72);
  static const Color higlightColor = Color(0xffFFB531);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static ThemeData theme = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: whiteColor,
      textTheme: TextTheme(
          titleLarge: const TextStyle().titleLarge(),
          titleMedium: const TextStyle().titleMid(),
          titleSmall: const TextStyle().titleSmall(),
          displayLarge: const TextStyle().displyLarge(),
          displayMedium: const TextStyle().displyMid(),
          displaySmall: const TextStyle().displaySmall()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        color: whiteColor,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        buttonColor: higlightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ));
}
