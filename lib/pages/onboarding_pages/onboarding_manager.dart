import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/pages/onboarding_pages/onboarding_pages.dart';
import 'package:news_watch/pages/page_manager.dart';

//this widget manages the two onboarding pages
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  //page controller to manage the pageview
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0; //index of the current page

  //this function is used to navigate to the next page
  void nextScreen() {
    pageController.animateToPage(
      currentPage + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  //this function is used to navigate to the home page
  void startApp() {
    UserSettings.setShowHome(true); //set the show home setting to true to prevent onboarding screen from showing again
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PageManager(), //navigate to the page manager
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //show th page uder the status bar
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(), //this prevents the user from swiping to change the page
          controller: pageController,
          onPageChanged: (int page) {
            //update the current index when the page changes
            setState(() {
              currentPage = page;
            });
          },
          children: [

            WelcomePage(nextScreen: nextScreen), //continue button navigates to DataSelectionPage

            DataSelectionPage(nextScreen: startApp), //countinue button naivgates to pageManager

          ],
        ),
      )
    );
  }
}