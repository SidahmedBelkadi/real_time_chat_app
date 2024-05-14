import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),

  // AppBar
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),

  // Input
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Colors.blue),
    ),
  ),

  // Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  ),
);
