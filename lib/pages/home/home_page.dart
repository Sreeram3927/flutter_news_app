import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_watch/widgets/news_feed.dart';
import 'package:news_watch/widgets/trending_news_feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ScrollController horizontalController = ScrollController();
  final ScrollController verticalController = ScrollController();

  @override
  void dispose() {
    horizontalController.dispose();
    verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: verticalController,
      slivers: [
        SliverToBoxAdapter(
          child: CarouselSlider(
            items: const [
              TrendingNewsFeed(),
              TrendingNewsFeed(),
              TrendingNewsFeed(),
              TrendingNewsFeed(),
              TrendingNewsFeed(),
            ],
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
          )
        ),
      ],
    );
  }
}