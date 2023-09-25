import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/widgets/news_cards.dart';
import 'package:news_watch/widgets/top_bar.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => false;

  final List<News> bookmarks = List.generate(10, (index) {
    return News(
      title: "How to Watch: NASA's OSIRIS-REx Mission Bringing Asteroid Sample Back to Earth After Travelling for 3 Years",
      content: 'not for now',
      newsOutlet: 'timesnownews',
      timeAgo: '${index}h',
      webUrl: 'https://www.example.com',
      imageUrl: 'https://th.bing.com/th?id=OVFT.gqBmAH9mIZraTqwv8FOKVS&pid=News&w=234&h=132&c=14&rs=2&qlt=90&dpr=1.3',
      newsOutletLogoUrl: 'https://www.bing.com/th?id=ODF.KANCozAEZYO1NwXNST5YDQ&pid=news&w=16&h=16&c=14&rs=2&qlt=90&dpr=1.3'
    );
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        const TopBar(
          title: Text("Bookmarks"),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return NewsFeedCard(news: bookmarks[index]);
            },
            childCount: bookmarks.length
          ),
        ),
      ],
      // child: ListView(
      //   children: bookmarks.map((news) => NewsFeedCard(news: news)).toList(),
      // ),
    );
  }
}