import 'package:flutter/material.dart';
import 'package:news_watch/pages/onboarding_pages/onboarding_pages.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  void nextScreen() {
    pageController.animateToPage(
      currentPage + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void startApp() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (int page) {
            setState(() {
              currentPage = page;
            });
          },
          children: [

              WelcomePage(nextScreen: nextScreen),

          ],
        ),
      )
    );
  }
}