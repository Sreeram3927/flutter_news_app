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
      onTap: () {
        showModalBottomSheet(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (context) {
            return NewsCard(news: news);
          }
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final News news;
  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
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
          if (news.imageUrl != null) ClipRRect(
            borderRadius: BorderRadius.circular(7.5),
            child: Image(
              image: NetworkImage(news.imageUrl!),
              fit: BoxFit.fitHeight,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              if (news.newsOutletLogoUrl != null) CircleAvatar(
                backgroundImage: NetworkImage(news.newsOutletLogoUrl!),
                radius: 12.5,
              ),
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
          ),
          const SizedBox(height: 10.0),
          Text(
            news.content,
            style: const TextStyle(
              fontSize: 17,
            ),
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