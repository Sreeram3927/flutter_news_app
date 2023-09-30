import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/pages/page_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSettings.localStorageInit();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PageManager(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,

        textTheme: GoogleFonts.mavenProTextTheme(),
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ), 
        ),

        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 3,
        ),

      ),
    );
  }
}
