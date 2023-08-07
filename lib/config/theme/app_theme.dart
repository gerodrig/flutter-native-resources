import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final bool isDark;

  AppTheme({this.isDark = false});

  ThemeData getTheme() => ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorSchemeSeed: Colors.blue,

      //Text
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserratAlternates(),
        titleMedium: GoogleFonts.montserratAlternates(fontSize: 35),
        titleSmall: GoogleFonts.roboto(fontSize: 25),
      ));
}
