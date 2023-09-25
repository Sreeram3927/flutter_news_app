import 'package:flutter/material.dart';
import 'package:news_watch/pages/bookmarks/bookmark_page.dart';
import 'package:news_watch/pages/home/home_page.dart';
import 'package:news_watch/pages/search/search_page.dart';
import 'package:news_watch/widgets/bottom_bar.dart';
import 'package:news_watch/widgets/top_bar.dart';

class PageManager extends StatefulWidget {
  const PageManager({super.key});

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {

  final PageController pageController = PageController();

  final List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    BookmarksPage(key: PageStorageKey('bookmarks'),),
    // Text('bookmarks'),
    Text("Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomBar(
        changePage: (index) => pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut
        ),
      ),
    );
  }
}