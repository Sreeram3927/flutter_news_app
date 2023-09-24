import 'package:flutter/material.dart';
import 'package:news_watch/widgets/news_feed.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  final List<Widget> bookmarks = const [
    NewsFeed(),
    NewsFeed(),
    NewsFeed(),
    NewsFeed(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: bookmarks
    );
  }
}