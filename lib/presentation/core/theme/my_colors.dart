import 'package:flutter/material.dart';

class MyColors {
  static MaterialColor mainGreen = _getMaterialColor(58, 216, 168, 0xFF3AD8A8);
  static MaterialColor mainYellow = _getMaterialColor(204, 216, 58, 0xFFCCD83A);
  static MaterialColor mainRed = _getMaterialColor(255, 143, 116, 0xFFFF8F74);
  static const Color mainOrange = Color(0xFFE8BC25);
  static MaterialColor grey = _getMaterialColor(167, 167, 167, 0xFFA7A7A7);
  static const Color borderGrey = Color(0x1A1A1A1A);
  static const Color primaryColor = Color(0xFF2BBF92);
  static const Color facebookBlue = Color(0xFF3C5A9A);
  static const Color lightGrey = Color(0xFF1A1A1A1A);

  /// Constant equivalent is [constDarkGrey].
  static MaterialColor textBlack = _getMaterialColor(26, 26, 26, 0xFF1A1A1A);
  static Color canvasColor = ThemeData.light().scaffoldBackgroundColor;

  static const Color constMainRed = Color(0xFFFF8F74);
  static const Color constMainYellow = Color(0xFFCCD83A);
  static const Color constMainGreen = Color(0xFF3AD8A8);

  static const Color searchBarGrey = Color(0xFFF7F7F7);

  static const chartYellow = Color(0xFFE8BC25);

  static const Color constDarkGrey = Color(0xFF1A1A1A);

  //slider Colors
  static const Color sliderDarkGreen = const Color(0xFF93CA65);
  static const Color sliderGold = const Color(0xFFE8BC25);
  static const Color sliderOrange = const Color(0xFFF3A64C);

  // category Colors
  static const Color orange = Color(0xFFF29E4C);
  static const Color accentOrange = Color(0xFFF1C453);
  static const Color categoryYellow = Color(0xFFE5E05C);
  static const Color accentGreen = Color(0xFFB9E769);
  static const Color turquoise = Color(0xFF16DB93);
  static const Color blueGreen = Color(0xFF0DB39E);
  static const Color categoryBlue = Color(0xFF298CB1);
  static const Color bluePurple = Color(0xFF5A82C1);
  static const Color categoryPurple = Color(0xFFA06AA2);
  static const Color fuchsia = Color(0xFFC75D87);
  static const Color categoryRed = Color(0xFFEC6F55);

  static MaterialColor _getMaterialColor(int r, int g, int b, var hex) {
    final Map<int, Color> data = {
      50: Color.fromRGBO(r, g, b, 0.1),
      100: Color.fromRGBO(r, g, b, 0.2),
      200: Color.fromRGBO(r, g, b, 0.3),
      300: Color.fromRGBO(r, g, b, 0.4),
      400: Color.fromRGBO(r, g, b, 0.5),
      500: Color.fromRGBO(r, g, b, 0.6),
      600: Color.fromRGBO(r, g, b, 0.7),
      700: Color.fromRGBO(r, g, b, 0.8),
      800: Color.fromRGBO(r, g, b, 0.9),
      900: Color.fromRGBO(r, g, b, 1.0),
    };
    return MaterialColor(hex, data);
  }
}
