import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsFeed extends StatelessWidget {
  final News news;
  const TrendingNewsFeed({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => news.additionalInfo(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              
              news.newsImage(
                width: double.infinity,
                height: 200,
              ),
            
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
                    news.aboutAuthor(
                        radius: 12.5,
                        width: 100,
                        height: 25,
                        fontSize: 17,
                      ),
                    const SizedBox(height: 6),
                    Text(
                      news.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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


class TrendingNewsFeedLoading extends StatelessWidget {
  const TrendingNewsFeedLoading({super.key});

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
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            
            _myShimmer(
              width: double.infinity,
              height: 200,
            ),
          
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
                  _myShimmer(width: 125, height: 15,),
                  const SizedBox(height: 6),
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