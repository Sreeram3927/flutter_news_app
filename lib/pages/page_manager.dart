import 'package:flutter/material.dart';
import 'package:news_watch/pages/bookmarks/bookmark_page.dart';
import 'package:news_watch/pages/home/home_page.dart';
import 'package:news_watch/pages/search/search_page.dart';
import 'package:news_watch/pages/settings/settings_page.dart';
import 'package:news_watch/widgets/bottom_bar.dart';

//this widget is used to manage the pages in the app
class PageManager extends StatefulWidget {
  const PageManager({super.key});

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {

  //this controller is used to manage the pageview
  final PageController pageController = PageController();

  //this list contains all the pages in the app
  final List<Widget> pages = const [
    HomePage(key: PageStorageKey('home'),),
    SearchPage(key: PageStorageKey('search'),),
    BookmarksPage(key: PageStorageKey('bookmarks'),),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController, //set the controller to the pagecontroller
        physics: const NeverScrollableScrollPhysics(), //disable the swipe to change page
        children: pages, //set the pages to the list of pages
      ),
      //set the bottom navigation bar to the bottombar widget
      bottomNavigationBar: BottomBar(
        //change the page when the user taps a different page
        //animate the page change
        changePage: (index) => pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutSine
        ),
      ),
    );
  }
}