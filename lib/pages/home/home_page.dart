import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/data/web_scraper.dart';
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
  get wantKeepAlive => false;

  bool isLoading = true;
  bool isError = false;

  String country = UserSettings.getSelectedCountry() ?? 'India';
  List<TrendingNewsFeed> countryNews = [];
  Future<void> getCountryNews() async {
    setState(() => isLoading = true);
    try {
      final data = await BingScraper.getData(query: country);
      countryNews = data
        .where((news) => news.imageURL != null)
        .map((news) => TrendingNewsFeed(news: news))
        .toList()
      ;
    } catch (e) {
      isError = true;
    }
    setState(() => isLoading = false);
  }

  List<Widget> favourites = [];
  void getFavourites() {
    setState(() => favourites = UserSettings.getUserFavourites()!.map((fav) => FavouriteNewsCard(favourite: fav)).toList());
  }

  Widget onError() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.signal_wifi_off_rounded),
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: getCountryNews,
            child: const Text('Retry')
          )
        ],
      ),
    );}

  @override
  void initState() {
    super.initState();
    getCountryNews();
    getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await getCountryNews();
        setState(() => getFavourites());
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
                  showCountryPicker(
                    context: context,
                    onSelect: (country) {
                      UserSettings.setSelectedCountry(country.name);
                      setState(() {
                        this.country = country.name;
                        getCountryNews();
                        getFavourites();
                      });
                    },
                  );
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 75,
                      child: Text(
                        country,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
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
          width: MediaQuery.of(context).size.width * 0.9,
          children: [
            CarouselSlider(
                items: isError
                  ? [onError()] 
                  : isLoading
                    ? List.generate(3, (index) => const TrendingNewsFeedLoading())
                    : countryNews
                  ,
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