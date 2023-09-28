import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';

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
                    Row(
                      children: [
                        news.newsOutletLogo(7),
                        const SizedBox(width: 6),
                        Text(
                          news.author,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white
                          ),
                        ),
                        Text(
                          " | ${news.timeAgo}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
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