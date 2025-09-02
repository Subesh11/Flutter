import 'package:flutter/material.dart';

// Light Mode Theme
ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(
      0xFFB0DEED,
    ), // A soft blue that sets the overall tone
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

// Dark Mode Theme
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFB0DEED), // Use the same seed color
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);
