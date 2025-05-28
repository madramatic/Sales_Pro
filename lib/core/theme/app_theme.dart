import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF004CC8),
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Inter',
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF004CC8),
      onPrimary: Colors.white,
      secondary: Color(0xFF333333),
      onSecondary: Color(0xFFA3A3A3),
      error: Color(0xFFFF486A),
      onError: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 8,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF004CC8),
        foregroundColor: Colors.white,
      ),
    ),
  );
}
