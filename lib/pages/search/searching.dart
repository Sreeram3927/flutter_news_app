import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/widgets/news_feed_card.dart';

class SearchSearching extends StatelessWidget {
  final List<News> data;
  const SearchSearching({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: List.generate(data.length, (index) => NewsFeedCard(news: data[index])).toList(),
      )
    );
  }
}