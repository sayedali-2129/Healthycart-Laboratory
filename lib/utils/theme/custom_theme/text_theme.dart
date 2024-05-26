import 'package:flutter/material.dart';

class BTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 32,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontWeight: FontWeight.w900,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black54,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black54,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black54,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black54,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black87,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black54,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black54,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black87,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 32.0,
        color: Color.fromARGB(255, 255, 255, 255),
        fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white70,
      fontWeight: FontWeight.w900,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Poppins',
      color: Color.fromARGB(255, 239, 236, 236),
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w700),
    bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white70,
        fontWeight: FontWeight.w600),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white60,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white60,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
        fontFamily: 'Poppins',
        color: Color.fromARGB(255, 207, 203, 203),
        fontWeight: FontWeight.w600),
  );
}
