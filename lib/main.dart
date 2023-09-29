import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/pages/page_manager.dart';
import 'package:news_watch/theme/theme_settings.dart';

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
      theme: ThemeSettings.lightMode,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.mavenProTextTheme(),
      ),
    );
  }
}
