import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xffEBF4FB),
  colorScheme: ColorScheme.light(
    primary: const Color(0xff1562AE),
    secondary: const Color(0xff3377BA),
    surface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff1562AE),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff1562AE),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);