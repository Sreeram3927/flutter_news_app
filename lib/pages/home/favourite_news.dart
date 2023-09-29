import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/web_scraper.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/title_and_child.dart';

class FavouriteNews extends StatefulWidget {
  final String favourite;
  const FavouriteNews({super.key, required this.favourite});

  @override
  State<FavouriteNews> createState() => _FavouriteNewsState();
}

class _FavouriteNewsState extends State<FavouriteNews> {
  bool isLoading = true;
  bool isError = false;
  late List<News> data;

  void _getData() async {
    setState(() => isLoading = true);
    try {
      data = await BingScraper.getData(widget.favourite);
    } catch (e) {
      isError = true;
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

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
        title: widget.favourite,
        border: true,
        onSeeAll: () {},
        children: isError
          ? [onError()]
          : isLoading
            ? List.generate(2, (index) => const NewsFeedCardLoading())
            : List.generate(2, (index) => NewsFeedCard(news: data[index])).toList()
          ,
      );
  }
}