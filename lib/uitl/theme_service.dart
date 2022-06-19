import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/uitl/constance.dart';

class ThemeService {
  static ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
    ),
    scaffoldBackgroundColor: whiteColor,
    textTheme:  TextTheme(
      bodyText1: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: Colors.white,
          height: 1.2,
        ),
      ),
      headline1: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: blackColor,
          height: 1.2,
        ),
      ),
      headline2: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: blackColor,
          height: 1.2,
        ),
      ),
      headline3: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 18,
          color: blackColor,
          height: 1.2,
        ),
      ),
      headline4: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 16,
          color: blackColor,
          height: 1.2,
        ),
      ),
      headline5: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 18,
          color: grayColor,
          height: 1.2,
        ),
      ),
    ),
  );
  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: blackColor,
    textTheme:  TextTheme(
      bodyText1: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: blackColor,
        ),
      ),
      headline1: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: whiteColor,
          height: 1.2,
        ),
      ),
      headline2: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: whiteColor,
          height: 1.2,
        ),
      ),
      headline3: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 18,
          color: primaryColor,
          height: 1.2,
        ),
      ),
      headline4: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 16,
          color: primaryColor,
          height: 1.2,
        ),
      ),
      headline5: GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 18,
          color: grayColor,
          height: 1.2,
        ),
      ),
    ),
  );
}