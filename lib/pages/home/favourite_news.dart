import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/web_scraper.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/title_and_child.dart';
import 'package:news_watch/widgets/top_bar.dart';

//this widget is used to show the favourite news of the user informs of short tiles
class FavouriteNewsCard extends StatefulWidget {
  final String favourite;
  const FavouriteNewsCard({
    super.key,
    required this.favourite,
  });

  @override
  State<FavouriteNewsCard> createState() => _FavouriteNewsCardState();
}

class _FavouriteNewsCardState extends State<FavouriteNewsCard> {
  bool isLoading = true; //used to check if the daata is loading
  bool isError = false; //used to check if there is an error while loading the data
  late List<News> data; //used to store the news data 

  //this function is used to get the data
  void _getData() async {
    setState(() => isLoading = true); //set the loading state to true
    try {
      //get the data from the web is form of news objects
      data = await BingScraper.getData(query: widget.favourite, addCountry: true); //add country to the query string
    } catch (e) {
      isError = true; //if there is an error, set the error state to true
    }
    setState(() => isLoading = false); //finally set loading to false
  }

  //the init state is used to get the data when the widget is created
  @override
  void initState() {
    super.initState();
    _getData(); //get the data
  }

  //this widget is shown when there is an error while loading the data
  Widget onError() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
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
          //the retry button is used to retry getting the data
          TextButton(
            onPressed: _getData,
            child: const Text('Retry')
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TitleAndChild(
        title: widget.favourite, //the title is the name of the favourite news
        border: true, //this makes sure the widget has some borders around it
        //the see all buttom is used to see all the news related to the favourite topic
        onSeeAll: () {
          if (data.isNotEmpty) { // navivate to the favourite news page only if there is data
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FavouriteNewsPage(
                    name: widget.favourite,
                    news: data,
                  );
                },
                //animate the navigation to the favourite news page
                //the new page slides from the bottom to the top
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          }
        },

        children: isError //check if there is an error
          ? [onError()] //if there is an error, show the error widget
          : isLoading  //if there is no error, check if the data is loading
            ? List.generate(2, (index) => const NewsFeedCardLoading()) //if the data is loading, show the loading news feed card
            : List.generate(2, (index) => NewsFeedCard(news: data[index])).toList() //if the data is loaded, show the news feed card with the news data
          ,
      );
  }
}

//this widget is used to show the favourite news of the user in form of a list
class FavouriteNewsPage extends StatelessWidget {
  final String name;
  final List<News> news;
  const FavouriteNewsPage({
    super.key,
    required this.name,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TopBar(
            title: Text(name), //the title of the page is the name of the favourite news
          ),
          //the list of news is shown in a sliver list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => NewsFeedCard(news: news[index]), //returns a news feed card with the news data for every news
              childCount: news.length, //the number of news in the news list
            ),
          ),
        ],
      ),
    );
  }
}