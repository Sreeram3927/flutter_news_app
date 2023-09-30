import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';
import 'package:shimmer/shimmer.dart';

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
    return GestureDetector(
      onTap: () async {
        await widget.news.additionalInfo(context);
        setState(() {});
      },
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
                          widget.news.aboutAuthor(
                              radius: 7,
                              width: 100,
                              height: 30,
                              fontSize: 15,
                            ),
                          const SizedBox(height: 6),
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

class NewsFeedCardLoading extends StatelessWidget {
  const NewsFeedCardLoading({super.key});

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
                    _myShimmer(width: 150, height: 15),
                    const SizedBox(height: 6),
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
                child: _myShimmer(width: 135, height: 85)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
