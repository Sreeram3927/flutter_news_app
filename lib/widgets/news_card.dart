import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';

class NewsCard extends StatelessWidget {
  final News news;
  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          const SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(7.5),
            child: news.newsImage(
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              news.newsOutletLogo(12.5),
              const SizedBox(width: 6),
              Text(
                news.newsOutlet,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                " | ${news.timeAgo}",
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            news.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10.0),
          Text(
            news.content,
            style: const TextStyle(
              fontSize: 17,
            ),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(news.isBookmarked ? Icons.bookmark_added_rounded : Icons.bookmark_add_rounded),
                label: Text(
                  news.isBookmarked ? "Bookmarked" : "Bookmark",
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                )
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_rounded),
                label: const Text(
                  "Share",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                )
              )
            ],
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 50))
            ),
            child: const Text(
              "Visit Website",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ]
      ),
    );
  }
}