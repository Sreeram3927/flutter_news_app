import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:shimmer/shimmer.dart';

//this widget is used to show the trending news in feed
class TrendingNewsFeed extends StatelessWidget {
  final News news;
  const TrendingNewsFeed({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    //a gesture detector is used to detect the user taps
    return GestureDetector(
      //call the additionalInfo(NewsCard) function when the user taps on the widget
      onTap: () => news.additionalInfo(context),
      child: Padding( //add padding to the widget
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          //a stack is used to display the news informations
          //on top to the image
          child: Stack(
            children: [
              
              //this is the image of the news
              news.newsImage(
                width: double.infinity, //set maximum width
                height: 200, //set height
              ),

              //show a gradient on top of the image
              //make the bottom part a bit darker than the top part
              //this help is better visibility of the 
              //news informations
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black], 
                    ),
                  ),
                ),
              ),

              //this is the news informations
              //poisiton the informations at the bottom of the image
              Positioned(
                left: 8.0,
                right: 8.0,
                bottom: 8.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //this is the imformation about author of the news
                    news.aboutAuthor( 
                        radius: 12.5, //for small logo
                        width: 100, //for big logo
                        height: 25, //for big logo
                        fontSize: 17, //font size of the author name and time ago
                      ),
                    const SizedBox(height: 6),
                    //this is the title of the news
                    Text(
                      news.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      //make the title to be in 3 lines
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis, //show ... if the title is too long
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//this widget is used to show the loading animation for the trending news feed
class TrendingNewsFeedLoading extends StatelessWidget {
  const TrendingNewsFeedLoading({super.key});

  //a shimmer is used to show that the data is loading
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
    return Padding( ///add padding to the widget
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        //a stack is used to display shimmer for image
        // and news informations
        child: Stack(
          children: [

            //this is the shimmer for the image
            _myShimmer(
              width: double.infinity, //set maximum width
              height: 200, //set height
            ),

            //show a gradient on top of the image
            //just like the original treding news feed
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black], 
                  ),
                ),
              ),
            ),
          
            Positioned(
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //this shimmer is used to show the loading animation for about author
                  _myShimmer(width: 125, height: 15,),
                  const SizedBox(height: 6),
                  //three shimmers are used to indicaate the loading of the title
                  _myShimmer(width: double.infinity, height: 17),
                  const SizedBox(height: 6),
                  _myShimmer(width: double.infinity, height: 17),
                  const SizedBox(height: 6),
                  _myShimmer(width: double.infinity, height: 17),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}