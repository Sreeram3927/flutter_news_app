import 'package:flutter/material.dart';
import 'package:news_watch/widgets/bottom_bar.dart';
import 'package:news_watch/widgets/news_feed.dart';
import 'package:news_watch/widgets/top_bar.dart';
import 'package:news_watch/widgets/trending_news_feed.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      extendBodyBehindAppBar: true,
      body: ListView(
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
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}