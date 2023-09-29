import 'package:flutter/material.dart';
import 'package:news_watch/data/favourites.dart';
import 'package:news_watch/data/news.dart';

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

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: isLoading ? CircularProgressIndicator() : Text(widget.favourite.name),
    );
  }
}