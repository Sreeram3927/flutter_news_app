import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/widgets/news_feed_card.dart';
import 'package:news_watch/widgets/top_bar.dart';


//this page shows all the bookmarked news of the user
class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> with AutomaticKeepAliveClientMixin {

  //this is used to make sure that the page does not stay in alive
  //meaning the page gets rebuilt when the user navigates to it
  @override
  bool get wantKeepAlive => false;

  // final List<News> bookmarks = List.generate(10, (index) {
  //   return News(
  //     title: "How to Watch: NASA's OSIRIS-REx Mission Bringing Asteroid Sample Back to Earth After Travelling for 3 Years",
  //     content: 'not for now',
  //     author: 'timesnownews',
  //     timeAgo: '${index}h',
  //     webURL: 'https://www.example.com',
  //     imageURL: 'th?id=OVFT.gqBmAH9mIZraTqwv8FOKVS&pid=News&w=234&h=132&c=14&rs=2&qlt=90&dpr=1.3',
  //     authorLogoURL: 'th?id=ODF.KANCozAEZYO1NwXNST5YDQ&pid=news&w=16&h=16&c=14&rs=2&qlt=90&dpr=1.3',
  //     isBookmarked: true
  //   );
  // });

  //get the list of bookmarks from the user settings(local storage)
  List<News> bookmarks = UserSettings.getBookmarks();

  //this widget is shown when there are no bookmarks
  //its just a text saying no bookmarks in the center of the screen
  Widget emptyData() {
    return const SliverFillRemaining(
      child: Center(
        child: Text(
          'No Bookmarks',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        const TopBar(
          title: Text("Bookmarks"), //the title of the page
        ),
        //if there are no bookmarks, show the emptyData widget
        //else show the list of bookmarks
        bookmarks.isEmpty ? emptyData() : SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return NewsFeedCard(news: bookmarks[index]); //returns a news feed card with the news data for every news
            },
            //the number of news in the bookmarks list
            childCount: bookmarks.length
          ),
        ),
      ],
    );
  }
}