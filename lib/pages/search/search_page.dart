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
  bool isError = false;
  final FocusNode _searchFocusNode = FocusNode();
  late String title;
  late List<News> data;

  Future<void> _search(String query) async {
    setState(() {
      title = query;
      isLoading = true;
    });
    try {
      data = await BingScraper.getData(query);
    } catch (e) {
      isError = true;
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget onError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.signal_wifi_off_rounded),
          const SizedBox(height: 15),
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () async {
              await _search(title);
            },
            child: const Text('Retry')
          )
        ],
      ),
    );
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
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await _search(title);
      },
      child: CustomScrollView(
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
    
          TitleAndChild(
            title: title,
            children: isError
              ? [onError()]
              : isLoading
                ? List.generate(10, (index) => const NewsFeedCardLoading())
                : data.map((news) => NewsFeedCard(news: news)).toList(),
          )
    
          // if (isSearching)
        ],
      ),
    );
  }
}