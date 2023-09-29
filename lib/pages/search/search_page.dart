import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/web_scraper.dart';
import 'package:news_watch/pages/search/searching.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/title_and_child.dart';
import 'package:news_watch/widgets/top_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>  with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  bool isSearching = false;
  bool isLoading = true;
  final FocusNode _searchFocusNode = FocusNode();
  String title = 'Top Stories';
  late List<News> data;

  void _search(String query) async {
    setState(() {
      title = query;
      isLoading = true;
    });
    data = await BingScraper.getData(query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _search('Top Stories');
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

        TopBar(
          leading: isSearching ? IconButton(
            splashColor: Colors.blue[300],
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                isSearching = false;
                _searchFocusNode.unfocus();
              });
            },
          ) : null,
          title: SizedBox(
            height: 40,
            child: TextField(
              focusNode: _searchFocusNode,
              onTap: () {
                setState(() {
                  isSearching = true;
                });
              },
              onTapOutside: (event) {
                setState(() {
                  isSearching = false;
                  _searchFocusNode.unfocus();
                });
              },
              decoration: InputDecoration(
                hintText: "Search...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),

        if(!isLoading) TitleAndChild(
          title: title,
          children: data.map((news) => NewsFeedCard(news: news)).toList(),
        )

        // if (isSearching)
      ],
    );
  }
}