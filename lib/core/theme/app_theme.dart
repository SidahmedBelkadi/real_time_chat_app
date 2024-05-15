import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getAppTheme({required BuildContext context}) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Theme.of(context).colorScheme.primary),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),

    // AppBar
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      refreshBackgroundColor: Theme.of(context).colorScheme.primary,
      color: Colors.white,
    ),

    // Input
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
    ),

    // Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
