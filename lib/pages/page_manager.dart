import 'package:flutter/material.dart';
import 'package:news_watch/data/web_scraper.dart';
import 'package:news_watch/pages/bookmarks/bookmark_page.dart';
import 'package:news_watch/pages/home/home_page.dart';
import 'package:news_watch/pages/search/search_page.dart';
import 'package:news_watch/pages/settings/settings_page.dart';
import 'package:news_watch/widgets/bottom_bar.dart';

class PageManager extends StatefulWidget {
  const PageManager({super.key});

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {

  final PageController pageController = PageController();

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
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: BottomBar(
        changePage: (index) => pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutSine
        ),
      ),
    );
  }
}