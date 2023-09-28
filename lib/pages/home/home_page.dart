import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/pages/home/country_selection.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/top_bar.dart';
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
      content: 'OSIRIS-REx was a NASA asteroid-study and sample-return mission that visited and collected samples from 101955 Bennu, a carbonaceous near-Earth asteroid.[12] The material, returned in September 2023,[13] is expected to enable scientists to learn more about the formation and evolution of the Solar System, its initial stages of planet formation, and the source of organic compounds that led to the formation of life on Earth.[14] Following the completion of the primary mission, the spacecraft is planned to conduct proximity operations and in-depth study of asteroid 99942 Apophis as OSIRIS-APEX.[15]',
      newsOutlet: 'timesnownews',
      timeAgo: '${index}h',
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
          content: 'OSIRIS-REx was a NASA asteroid-study and sample-return mission that visited and collected samples from 101955 Bennu, a carbonaceous near-Earth asteroid.[12] The material, returned in September 2023,[13] is expected to enable scientists to learn more about the formation and evolution of the Solar System, its initial stages of planet formation, and the source of organic compounds that led to the formation of life on Earth.[14] Following the completion of the primary mission, the spacecraft is planned to conduct proximity operations and in-depth study of asteroid 99942 Apophis as OSIRIS-APEX.[15]',
          newsOutlet: 'timesnownews',
          timeAgo: '${index}h',
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
        
        TopBar(
          title: const Text(
            'News Watch',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CountrySelectionPage())
                );
              },
              child: Row(
                children: [
                  Text(
                    UserSettings.selectedCountry,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.location_pin)
                ],
              ),
            )
          ],
        ),

        SliverToBoxAdapter(
          child: CarouselSlider(
            items: List.generate(10, (index) {
              return TrendingNewsFeed(
                news: News(
                  title: "How to Watch: NASA's OSIRIS-REx Mission Bringing Asteroid Sample Back to Earth After Travelling for 3 Years",
                  content: 'not for now',
                  newsOutlet: 'timesnownews',
                  timeAgo: '${index}h',
                  webUrl: 'https://www.example.com',
                  imageUrl: 'https://th.bing.com/th?id=OVFT.gqBmAH9mIZraTqwv8FOKVS&pid=News&w=234&h=132&c=14&rs=2&qlt=90&dpr=1.3',
                  newsOutletLogoUrl: 'https://www.bing.com/th?id=ODF.KANCozAEZYO1NwXNST5YDQ&pid=news&w=16&h=16&c=14&rs=2&qlt=90&dpr=1.3'
                )
              );
            }),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 7),
              enableInfiniteScroll: false,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enlargeFactor: 0.215,
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