import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/data/web_scraper.dart';
import 'package:news_watch/pages/home/favourite_news.dart';
import 'package:news_watch/widgets/title_and_child.dart';
import 'package:news_watch/widgets/top_bar.dart';
import 'package:news_watch/widgets/trending_news_feed.dart';


//this is the home page of the app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  //this ensure that the page is not kept alive
  //and is rebuild every time the user navigates to it
  @override
  get wantKeepAlive => false;

  bool isLoading = true; //used to check if the data is loading
  bool isError = false; //used to check if there is an error while loading the data

  String country = UserSettings.getSelectedCountry() ?? 'India'; //get the selected country from the user settings, if null set India as default
  List<TrendingNewsFeed> countryNews = []; //used to store the trending news data
  //this function is used to get the trending news data
  Future<void> getCountryNews() async {
    setState(() => isLoading = true); //first set the loading state to true
    try {
      final data = await BingScraper.getData(query: country); //try to get the news data from the web, using country name as the query string
      //filter the data that does not have an image
      //as the image is shown in the background
      countryNews = data
        .where((news) => news.imageURL != null) //filter the news data to remove the news without images
        .map((news) => TrendingNewsFeed(news: news)) //convert the news data to TrendingNewsFeed widgets
        .toList() //return as aa list
      ;
    } catch (e) {
      isError = true; //if there is an error, set the error state to true
    }
    setState(() => isLoading = false); //finally set loading to false
  }

  List<Widget> favourites = []; //used to store the favourite news data
  //this function is used to get the favourite news data
  void getFavourites() {
    //get the favourite news data from the user settings
    //and return a FavouriteNews card for each favoutire topic
    setState(() => favourites = UserSettings.getUserFavourites()!.map((fav) => FavouriteNewsCard(favourite: fav)).toList());
  }

  //this widget is shown when there is an error while loading the data
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
          //shows the user that there is an error while getting the daata
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          //the retry button is used to retry getting the data
          TextButton(
            onPressed: getCountryNews,
            child: const Text('Retry')
          )
        ],
      ),
    );
  }

  //the init state is used to get the data when the widget is created
  @override
  void initState() {
    super.initState();
    getCountryNews(); //get the country(trending) news data
    getFavourites(); //get the favourite news data
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      //the refresh indicator is used to refresh the data
      //user can pull down to refresh the data
      onRefresh: () async {
        await getCountryNews();
        setState(() => getFavourites());
      },
      child: CustomScrollView(
        slivers: [
          //the top bar is the app bar of the page
          TopBar(
            title: const Text(
              'News Watch', //the title of the home page
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            //actions are shown in the right side of the app bar
            actions: [
              //shows a button to select country
              OutlinedButton(
                //when pressed, it shows a country picker
                onPressed: () {
                  showCountryPicker(
                    context: context,
                    onSelect: (country) {
                      //when the user selects a country update the local storage
                      UserSettings.setSelectedCountry(country.name);
                      //and update the state of the widget with the new country
                      setState(() {
                        this.country = country.name;
                        getCountryNews();
                        getFavourites();
                      });
                    },
                  );
                },
                //this is what shown inside the button
                child: Row(
                  children: [
                    SizedBox(
                      width: 75,
                      //first show the name of the current selected country
                      child: Text(
                        country, //current selected country
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        //this ensures that the name dosent overflow
                        //if it does it shows ... at the end
                        //some countries have long name so this is required
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
        
         //the trending news feed is shown in the home page
         TitleAndChild(
          title: 'Happening in $country', //the title of the trending news feed
          width: MediaQuery.of(context).size.width * 0.9,
          //the news is shown in a carousel slider
          children: [
            CarouselSlider(
              //the carousel slider only takes a list of widgets
                items: isError //check if there is an error while loading the data
                  ? [onError()]  //if there is an error, show the error widget as a list
                  : isLoading //check if the data is loading
                    ? [const TrendingNewsFeedLoading()] //if the data is loading, show the loading widget as a list
                    : countryNews  //if the data is loaded, show the news data
                  ,
                //the options for the carousel slider are set here
                options: CarouselOptions(
                  autoPlay: true, //set this to true to auto play the carousel
                  autoPlayInterval: const Duration(seconds: 7), //set the interval between each slide transiton
                  aspectRatio: 2.0, //used uf no height is given
                  enlargeCenterPage: true, //set this to true to enlarge the current news shown
                  enlargeFactor: 0.215, //set the enlarge factor of the current news shown
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
              )
            ]
          ),

          //the favourite news is shown in the home page
          //... is used to add all the elements in the list of favourite news to this widget list
          ...favourites,
         
        ],
      ),
    );
  }
}