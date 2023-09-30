import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/web_scraper.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/title_and_child.dart';
import 'package:news_watch/widgets/top_bar.dart';

//this page is used to search for news with a key word
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>  with AutomaticKeepAliveClientMixin {

  //this is used to make sure the page does not stay in memory
  //meaning the widget rebuilds every time the user navigates to it
  @override
  bool get wantKeepAlive => false;

  bool isSearching = false; //used to check if the use is searching
  bool isLoading = true; //used to check if the data is loading
  bool isError = false; //used to check if there is an error
  final FocusNode _searchFocusNode = FocusNode(); //used to control search bar foucus
  final TextEditingController _searchController = TextEditingController(); //used to control search bar text
  late String title; //used to store the search query
  late List<News> data; //used to store the search results

  //this function is used to search for news
  Future<void> _search(String query, bool addCountry) async {
    //firstly, set loading to true and the title to the query
    setState(() {
      title = query;
      isLoading = true;
    });
    try {
      //then, try to get the data
      data = await BingScraper.getData(query: query, addCountry: addCountry);
    } catch (e) {
      isError = true; //if there is an error, set isError to true
    }
    setState(() {
      isLoading = false; //finally set loading to false
    });
  }

  //this widget is used to display an error message
  Widget onError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.signal_wifi_off_rounded),
          const SizedBox(height: 15),
          //tell the user that something went wrong
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          //button to retry
          TextButton(
            onPressed: () async {
              await _search(title, false);
            },
            child: const Text('Retry')
          )
        ],
      ),
    );
  }

  //this function is used to initialize the page
  @override
  void initState() {
    super.initState();
    _search('Latest news', true); //search for latest news on initialization
  }

  //this function is used to dispose the page
  @override
  void dispose() {
    _searchFocusNode.dispose(); //dispose the focus node
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //the refresh indicator is used to refresh the daata
    //user can pull down to refresh
    return RefreshIndicator(
      //when the user pulls down, refresh the data
      onRefresh: () async {
        await _search(title, false);
      },
      child: CustomScrollView(
        slivers: [
          
          //this is the search bar
          TopBar(
            leading: isSearching ? IconButton( //if the search bar is focused, show a back button
              splashColor: Colors.blue[300],
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                //when the user presses the back button, unfocus the search bar
                setState(() {
                  isSearching = false;
                  _searchFocusNode.unfocus();
                });
              },
            ) : null,
            title: SizedBox(
              height: 40,
              //initialize the search bar
              child: TextField(
                focusNode: _searchFocusNode, //set the focus node
                controller: _searchController, //set the text controller
                //when the user taps on the search bar, set isSearching to true
                onTap: () {
                  setState(() {
                    isSearching = true;
                  });
                },
                //when the user taps outside the search bar, unfocus the search bar
                onTapOutside: (event) {
                  setState(() {
                    isSearching = false;
                    _searchFocusNode.unfocus();
                  });
                },
                //when the user submits the search query using the keyboard
                //unfocus the search bar and search for the query
                onSubmitted: (query) {
                  _searchFocusNode.unfocus();
                  _search(query, false);
                },
                //show a hint text and a search icon
                decoration: InputDecoration(
                  hintText: "Search...", //hint text
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search), //search icon
                    //when the user presses the search icon
                    //unfocus the search bar and search for the query
                    onPressed: () {
                      _searchFocusNode.unfocus();
                      _search(_searchController.text, false);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),

          //show the search results
          TitleAndChild(
            title: title, //set the title to the search query
            children: isError //check for error
              ? [onError()] //if there is an error, show the error message
              : isLoading //if not, check for loading
                ? List.generate(10, (index) => const NewsFeedCardLoading()) //if loading, show loading cards
                : data.map((news) => NewsFeedCard(news: news)).toList(), //if not, show the search results
          )
    
          // if (isSearching)
        ],
      ),
    );
  }
}