import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // light theme
  static final ThemeData lightTheme = ThemeData(
    // scaffoldBackgroundColor: Colors.teal,
    scaffoldBackgroundColor: Colors.grey[200],
    appBarTheme: const AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black54),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.black87)
    ),
  );

  // dark theme
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[800],
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white54),
    textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white)),
  );
}
