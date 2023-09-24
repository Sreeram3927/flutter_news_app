import 'package:flutter/material.dart';
import 'package:news_watch/widgets/news_feed.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          // enableSuggestions: true,
          decoration: InputDecoration(
            hintText: "Search...",
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: const [
              NewsFeed(),
              NewsFeed(),
              NewsFeed(),
              NewsFeed(),
              NewsFeed(),
              NewsFeed(),
              NewsFeed(),
              NewsFeed(),
              NewsFeed(),
              NewsFeed(),
            ],
          ),
        ),
      ],
    );
  }
}