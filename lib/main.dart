import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/pages/onboarding_pages/onboarding_manager.dart';
import 'package:news_watch/pages/page_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //call this if you're running any code before runApp()
  await UserSettings.localStorageInit(); //initialize local storage(shared_preferences)
  runApp(MainApp()); //run the app
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  //check weather this user had already seen the onboarding page
  final bool showHome = UserSettings.getShowHome() ?? false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //this is the root widget of the app
      title: 'News Watch', //title of the app
      //if the user had already seen the onboarding page, show the home page, else show the onboarding page
      home: showHome ? const PageManager() : const OnboardingPage(),
      themeMode: ThemeMode.light, //set the theme to light mode
      //define the light mode theme
      theme: ThemeData(
        useMaterial3: true, //use material 3.0
        colorSchemeSeed: Colors.blue, //set the color scheme seed of the app

        textTheme: GoogleFonts.mavenProTextTheme(), //set the text theme of the app
        //define the primary text theme
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ), 
        ),
        //define the card theme
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 3,
        ),

      ),
    );
  }
}
