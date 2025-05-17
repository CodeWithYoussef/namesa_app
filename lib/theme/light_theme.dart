import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namesa_yassin_preoject/theme/base_theme.dart';

class LightTheme extends BaseTheme {
  @override
  Color get backgroundColor => Color(0xff000000);

  @override
  Color get primaryColor => Color(0xffFFFFFF);

  @override
  Color get focusColor => Color(0xffBE7C01);

  Color get shadowColor => Color(0x38F5F5F5);

  Color get cardColor => Color(0xffD9D9D9);

  @override
  ThemeData get themeData => ThemeData(
    ///bg color
    scaffoldBackgroundColor: backgroundColor,

    ///primary color
    primaryColor: primaryColor,

    ///focusColor
    focusColor: focusColor,

    ///shadow Color
    shadowColor: shadowColor,

    ///cardColor
    cardColor: cardColor,

    ///splashFactory
    splashFactory: NoSplash.splashFactory,

    ///bottom navigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: focusColor,
      unselectedItemColor: Colors.white,
    ),

    ///icon Theme
    iconTheme: IconThemeData(color: Colors.white),

    ///text Theme
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.kurale(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.kurale(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.kurale(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      titleSmall: GoogleFonts.kurale(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );
}
