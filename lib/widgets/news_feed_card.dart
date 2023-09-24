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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (news.newsOutletLogoUrl != null) CircleAvatar(
                          backgroundImage: NetworkImage(news.newsOutletLogoUrl!),
                          radius: 7,
                        ),
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
              if (news.imageUrl != null) ClipRRect(
                borderRadius: BorderRadius.circular(7.5),
                child: Image(
                  image: NetworkImage(news.imageUrl!),
                  fit: BoxFit.fitHeight,
                  width: 135,
                  height: 85,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}