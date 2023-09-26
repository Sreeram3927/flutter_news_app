import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/top_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  bool isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();

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

        if(!isSearching) SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
                return NewsFeedCard(news: News(
                  title: "How to Watch: NASA's OSIRIS-REx Mission Bringing Asteroid Sample Back to Earth After Travelling for 3 Years",
                  content: 'not for now',
                  newsOutlet: 'timesnownews',
                  timeAgo: '${index}h',
                  webUrl: 'https://www.example.com',
                  imageUrl: 'https://th.bing.com/th?id=OVFT.gqBmAH9mIZraTqwv8FOKVS&pid=News&w=234&h=132&c=14&rs=2&qlt=90&dpr=1.3',
                  newsOutletLogoUrl: 'https://www.bing.com/th?id=ODF.KANCozAEZYO1NwXNST5YDQ&pid=news&w=16&h=16&c=14&rs=2&qlt=90&dpr=1.3'
                )
              );
            },
            childCount: 10
          ),
        ),
      ],
    );
  }
}