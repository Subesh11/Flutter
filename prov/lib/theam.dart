import 'package:flutter/material.dart';

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.grey,
    onPrimary: Colors.white,
    secondary: Colors.blueGrey,
    onSecondary: Colors.black12,
    error: Colors.red,
    onError: Colors.red,
    surface: Colors.black26,
    onSurface: Colors.white,
  ),
);
ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.black12,
    onPrimary: Colors.black12,
    secondary: Colors.blueGrey,
    onSecondary: Colors.black38,
    error: Colors.red,
    onError: Colors.redAccent,
    surface: Colors.black45,
    onSurface: Colors.black87,
  ),
);
