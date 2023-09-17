import 'package:flutter/material.dart';
import 'package:quiz/theme/my_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    background: white,
    // seedColor: purple,
    primary: orange,
    secondary: blue,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: purple,
  ),
);
