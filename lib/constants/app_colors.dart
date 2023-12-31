import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color darkBlue = Color(0xFF0F2550);
  static const Color lightBlue = Color(0xFF5A74A3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xE89D9D9D);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFFF44336);

  // Transparent colors
  static const Color transparent = Color(0x00000000);
  static const Color transparentDarkBlue = Color(0x6F0F2550);

  // Material color for defaultColor
  static MaterialColor defaultColor = const MaterialColor(
    0xFF0F2550,
    <int, Color>{
      050: darkBlue,
      100: darkBlue,
      200: darkBlue,
      300: darkBlue,
      500: darkBlue,
      400: darkBlue,
      600: darkBlue,
      700: darkBlue,
      800: darkBlue,
      900: darkBlue,
    },
  );
}
