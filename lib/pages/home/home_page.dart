import 'package:flutter/material.dart';
import 'package:news_watch/widgets/news_feed.dart';
import 'package:news_watch/widgets/trending_news_feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TrendingNewsFeed(),
        NewsFeed(),
        NewsFeed(),
        NewsFeed(),
        NewsFeed(),
        NewsFeed(),
        NewsFeed(),
        NewsFeed(),
        NewsFeed(),
        NewsFeed(),
      ],
    );
  }
}