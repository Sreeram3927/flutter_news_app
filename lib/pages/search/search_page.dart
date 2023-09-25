import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/widgets/news_cards.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

        SliverAppBar(
          floating: true,
          snap: true,
          // backgroundColor: Colors.transparent,
          flexibleSpace: TextField(
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


        SliverList(
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