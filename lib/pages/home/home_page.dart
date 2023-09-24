import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/trending_news_feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ScrollController horizontalController = ScrollController();
  final ScrollController verticalController = ScrollController();

  final List<News> items = List.generate(10, (index) {
    return News(
      title: "How to Watch: NASA's OSIRIS-REx Mission Bringing Asteroid Sample Back to Earth After Travelling for 3 Years",
      content: 'not for now',
      newsOutlet: 'timesnownews',
      timeAgo: '$index h',
      webUrl: 'https://www.example.com',
      imageUrl: 'https://th.bing.com/th?id=OVFT.gqBmAH9mIZraTqwv8FOKVS&pid=News&w=234&h=132&c=14&rs=2&qlt=90&dpr=1.3',
      newsOutletLogoUrl: 'https://www.bing.com/th?id=ODF.KANCozAEZYO1NwXNST5YDQ&pid=news&w=16&h=16&c=14&rs=2&qlt=90&dpr=1.3'
    );
  });
  final int maxCount = 30;
  int itemCount = 10;

  Future<void> _loadMoreItems() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      items.addAll(List.generate(5, (index) {
        return News(
          title: "How to Watch: NASA's OSIRIS-REx Mission Bringing Asteroid Sample Back to Earth After Travelling for 3 Years",
          content: 'not for now',
          newsOutlet: 'timesnownews',
          timeAgo: '$index h',
          webUrl: 'https://www.example.com',
          // imageUrl: 'https://th.bing.com/th?id=OVFT.gqBmAH9mIZraTqwv8FOKVS&pid=News&w=234&h=132&c=14&rs=2&qlt=90&dpr=1.3',
          // newsOutletLogoUrl: 'https://www.bing.com/th?id=ODF.KANCozAEZYO1NwXNST5YDQ&pid=news&w=16&h=16&c=14&rs=2&qlt=90&dpr=1.3'
        );
      }));
      itemCount += 5;
    });
  }

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

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index < items.length) {
                return NewsFeedCard(news: items[index]);
              } else if (index == itemCount) {
                if (itemCount >= maxCount) return null;
                _loadMoreItems();
                return const Center(child: CircularProgressIndicator());
              } else {
                return null;
              }
            },
            childCount: itemCount + 1
          ),
        ),
      ],
    );
  }
}