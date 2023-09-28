import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeSettings {
  
  static ThemeData lightMode = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,

   primaryTextTheme: GoogleFonts.mavenProTextTheme(),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ), 
    ),

    cardTheme: const CardTheme(
      color: Colors.white,
      elevation: 5,
    ),

  );

}