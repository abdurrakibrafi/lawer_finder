import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawer_finder/app/theme.dart';

extension AppText on TextStyle {
  TextStyle titleLarge() => GoogleFonts.poppins(
      fontSize: 28.0, color: AppTheme.blackColor, fontWeight: FontWeight.bold);
  TextStyle titleMid() => GoogleFonts.poppins(
      fontSize: 24.0, color: AppTheme.blackColor, fontWeight: FontWeight.w600);
  TextStyle titleSmall() => GoogleFonts.poppins(
        fontSize: 20.0,
        color: AppTheme.blackColor,
      );

  TextStyle displyLarge() =>
      GoogleFonts.poppins(fontSize: 28.0, color: AppTheme.blackColor);
  TextStyle displyMid() =>
      GoogleFonts.poppins(fontSize: 20.0, color: AppTheme.blackColor);
  TextStyle displaySmall() => GoogleFonts.poppins(
        fontSize: 14.0,
        color: AppTheme.blackColor,
      );
}
