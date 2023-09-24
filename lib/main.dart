import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_watch/pages/page_manager.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PageManager(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        textTheme: GoogleFonts.mavenProTextTheme(),
      ),
    );
  }
}
