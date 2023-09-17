import 'package:flutter/material.dart';
import 'package:quiz/theme/my_colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: black,
    primary: purple,
    secondary: blue,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: black,
  ),
);
