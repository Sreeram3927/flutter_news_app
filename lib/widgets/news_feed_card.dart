import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';

class NewsFeedCard extends StatelessWidget {
  final News news;
  const NewsFeedCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => news.additionalInfo(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Card(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              news.newsOutletLogo(7),
                              const SizedBox(width: 6),
                              Text(
                                news.newsOutlet,
                                style: const TextStyle(
                                  fontSize: 15,
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
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 7.5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7.5),
                      child: news.newsImage(
                        width: 135,
                        height: 85,
                      ),
                    ),
                  ],
                ),
              ),

              if (news.isBookmarked) Positioned(
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
