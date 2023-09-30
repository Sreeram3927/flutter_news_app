import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:shimmer/shimmer.dart';

//this widget is used to display the news in the news feed
class NewsFeedCard extends StatefulWidget {
  final News news;
  const NewsFeedCard({
    super.key,
    required this.news,
  });

  @override
  State<NewsFeedCard> createState() => _NewsFeedCardState();
}

class _NewsFeedCardState extends State<NewsFeedCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( //to detect the user taps
      onTap: () async {
        //show the additional info(NewsCard) of the news
        await widget.news.additionalInfo(context);
        setState(() {}); //update the state when the user returns form the Newscard
      },
      child: Padding( //add padding to the card
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Card(
          child: Stack( //this stack is used to display the bookmarked text
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          //this is the imformation about author of the news
                          widget.news.aboutAuthor(
                              radius: 7, //for small logo
                              width: 100, //for big logo
                              height: 30, //for big logo
                              fontSize: 15, //font size of the author name and time ago
                            ),
                          const SizedBox(height: 6),
                          //this is the title of the news
                          Text(
                            widget.news.title,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 7.5),
                    //this is the image of the news
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7.5),
                      child: widget.news.newsImage(
                        width: 135,
                        height: 85,
                      ),
                    ),
                  ],
                ),
              ),
              
              //this is the bookmarked text
              ///show ths only if the news is bookmarked
              if (widget.news.isBookmarked) Positioned(
                top: 15,
                right: -12,
                child: Transform.rotate(
                  angle: 45 * 3.14 / 180,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue ,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(3),
                    child: const Text(
                      'Bookmarked',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//this is the loading widget for the news feed card
class NewsFeedCardLoading extends StatelessWidget {
  const NewsFeedCardLoading({super.key});

  //a shimmer is used to display the loading animation
  Widget _myShimmer({required double width, required double height}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _myShimmer(width: 150, height: 15), //shimmer for about author
                    const SizedBox(height: 6),
                    //three shimmer are used to display the title loading
                    _myShimmer(width: double.infinity, height: 18),
                    const SizedBox(height: 6),
                    _myShimmer(width: double.infinity, height: 18),
                    const SizedBox(height: 6),
                    _myShimmer(width: double.infinity, height: 18),

                  ],
                ),
              ),
              const SizedBox(width: 7.5),
              ClipRRect(
                borderRadius: BorderRadius.circular(7.5),
                child: _myShimmer(width: 135, height: 85) //shimmer for news image
              ),
            ],
          ),
        ),
      ),
    );
  }
}
