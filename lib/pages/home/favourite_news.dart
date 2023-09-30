import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/web_scraper.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/title_and_child.dart';
import 'package:news_watch/widgets/top_bar.dart';

class FavouriteNewsCard extends StatefulWidget {
  final String favourite;
  const FavouriteNewsCard({
    super.key,
    required this.favourite,
  });

  @override
  State<FavouriteNewsCard> createState() => _FavouriteNewsCardState();
}

class _FavouriteNewsCardState extends State<FavouriteNewsCard> {
  bool isLoading = true;
  bool isError = false;
  late List<News> data;

  void _getData() async {
    setState(() => isLoading = true);
    try {
      data = await BingScraper.getData(query: widget.favourite, addCountry: true);
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
        onSeeAll: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return FavouriteNewsPage(
                  name: widget.favourite,
                  news: data,
                );
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        children: isError
          ? [onError()]
          : isLoading
            ? List.generate(2, (index) => const NewsFeedCardLoading())
            : List.generate(2, (index) => NewsFeedCard(news: data[index])).toList()
          ,
      );
  }
}


class FavouriteNewsPage extends StatelessWidget {
  final String name;
  final List<News> news;
  const FavouriteNewsPage({
    super.key,
    required this.name,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TopBar(
            title: Text(name),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => NewsFeedCard(news: news[index]),
              childCount: news.length,
            ),
          ),
        ],
      ),
    );
  }
}