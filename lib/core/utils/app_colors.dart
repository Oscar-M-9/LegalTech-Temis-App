import 'package:flutter/material.dart' show Color, Colors, MaterialColor;

abstract class AppColors {
  static const Color primary = Color.fromRGBO(10, 46, 77, 1);
  static const Color primary50 = Color(0xFFf0f8ff);
  static const Color primary100 = Color(0xFFe1f0fd);
  static const Color primary200 = Color(0xFFbbe2fc);
  static const Color primary300 = Color(0xFF80caf9);
  static const Color primary400 = Color(0xFF3cb0f4);
  static const Color primary500 = Color(0xFF1296e5);
  static const Color primary600 = Color(0xFF0677c3);
  static const Color primary700 = Color(0xFF065e9e);
  static const Color primary800 = Color(0xFF0a5082);
  static const Color primary900 = Color(0xFF0e436c);
  static const Color primary950 = Color(0xFF0a2e4d);
  static const Color secondary = Color.fromRGBO(225, 207, 64, 1);
  static const Color secondary50 = Color(0xFFfffbeb);
  static const Color secondary100 = Color(0xFFfff3c6);
  static const Color secondary200 = Color(0xFFffe588);
  static const Color secondary300 = Color(0xFFffcf40);
  static const Color secondary400 = Color(0xFFffbd20);
  static const Color secondary500 = Color(0xFFf99b07);
  static const Color secondary600 = Color(0xFFdd7302);
  static const Color secondary700 = Color(0xFFb75006);
  static const Color secondary800 = Color(0xFF943d0c);
  static const Color secondary900 = Color(0xFF7a330d);
  static const Color secondary950 = Color(0xFF461902);

  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color baseColor = Color(0xFFF7F7F7);

  static const Map<int, Color> color = {
    50: Color.fromRGBO(10, 46, 77, .1),
    100: Color.fromRGBO(10, 46, 77, .2),
    200: Color.fromRGBO(10, 46, 77, .3),
    300: Color.fromRGBO(10, 46, 77, .4),
    400: Color.fromRGBO(10, 46, 77, .5),
    500: Color.fromRGBO(10, 46, 77, .6),
    600: Color.fromRGBO(10, 46, 77, .7),
    700: Color.fromRGBO(10, 46, 77, .8),
    800: Color.fromRGBO(10, 46, 77, .9),
    900: Color.fromRGBO(10, 46, 77, 1),
  };
  static const MaterialColor primeColor = MaterialColor(0xFF0A2E4D, color);
}
