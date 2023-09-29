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
  late List<News> data;

  void _getData() async {
    data = await BingScraper.getData(widget.favourite);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return TitleAndChild(
        title: widget.favourite,
        border: true,
        onSeeAll: () {},
        children: isLoading
          ? List.generate(2, (index) => const NewsFeedCardLoading())
          : List.generate(2, (index) => NewsFeedCard(news: data[index])).toList(),
    );
  }
}