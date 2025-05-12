import 'dart:ui';

import 'package:flutter/material.dart';

abstract class BaseTheme {
  Color get primaryColor;

  Color get backgroundColor;

  Color get focusColor;

  ThemeData get themeData;
}
