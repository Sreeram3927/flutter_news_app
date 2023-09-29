import 'package:flutter/material.dart';
import 'package:news_watch/data/favourites.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/title_and_child.dart';

class FavouriteNews extends StatefulWidget {
  final Favourites favourite;
  const FavouriteNews({super.key, required this.favourite});

  @override
  State<FavouriteNews> createState() => _FavouriteNewsState();
}

class _FavouriteNewsState extends State<FavouriteNews> {
  bool isLoading = true;
  late List<News> data;

  @override
  void initState() {
    super.initState();
    widget.favourite.getData().then((value) {
      data = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget _loading() {
    return const SliverToBoxAdapter(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? _loading() : TitleAndChild(
        title: widget.favourite.name,
        border: true,
        onSeeAll: () {},
        children: List.generate(2, (index) => NewsFeedCard(news: data[index])).toList(),
    );
  }
}