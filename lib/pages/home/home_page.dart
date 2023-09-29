import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/data/web_scraper.dart';
import 'package:news_watch/pages/home/country_selection.dart';
import 'package:news_watch/pages/home/favourite_news.dart';
import 'package:news_watch/widgets/title_and_child.dart';
import 'package:news_watch/widgets/top_bar.dart';
import 'package:news_watch/widgets/trending_news_feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  get wantKeepAlive => true;

  bool isLoading = true;

  String country = UserSettings.getSelectedCountry();
  List<TrendingNewsFeed> countryNews = [];
  Future<void> _getCountryNews() async {
    setState(() => isLoading = true);
    final data = await BingScraper.getData(country);
    countryNews = data.map((news) => TrendingNewsFeed(news: news)).toList();
    setState(() => isLoading = false);
  }

  List<Widget> favourites = [];
  void _getFavourites() {
    favourites = UserSettings.getUserFavourites().map((fav) => FavouriteNews(favourite: fav)).toList();
  }

  @override
  void initState() {
    super.initState();
    _getCountryNews();
    _getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await _getCountryNews();
        setState(() => _getFavourites());
      },
      child: CustomScrollView(
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
                      country,
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
    
         TitleAndChild(
          title: 'Happening in $country',
          children: [
            CarouselSlider(
                items: isLoading 
                  ? List.generate(3, (index) => const TrendingNewsFeedLoading())
                  : countryNews.sublist(0, 6),
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 7),
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.215,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
              )
            ]
          ),
    
          ...favourites,
         
        ],
      ),
    );
  }
}