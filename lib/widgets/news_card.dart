import 'package:flutter/material.dart';
import 'package:news_watch/data/news.dart';

//this widget is used to display the news with the content
class NewsCard extends StatefulWidget {
  final News news;
  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding( //add padding to the card
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //this is the line at the top of the card
          Container(
            width: 50.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          const SizedBox(height: 10.0),
          //this is the image of the news
          ClipRRect(
            borderRadius: BorderRadius.circular(7.5),
            child: widget.news.newsImage( //get the image of the news
              width: double.infinity, //set maximux width
            ),
          ),
          const SizedBox(height: 10.0),
          //this is the imformation about author of the news
          widget.news.aboutAuthor(
              radius: 12.5, //for small logo
              width: 125, //for big logo
              height: 30, //for big logo
              fontSize: 17, //font size of the author name and time ago
            ),
          const SizedBox(height: 10.0),
          //this is the title of the news
          Text(
            widget.news.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10.0),
          //this is the content of the news
          Text(
            widget.news.content,
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
              //this is the button to bookmark the news
              ElevatedButton.icon(
                //call the bookmark function in the news class when the button is pressed
                onPressed: () => setState(() => widget.news.bookmark()),
                //update the bookmark icon accordingly
                icon: Icon(widget.news.isBookmarked ? Icons.bookmark_added_rounded : Icons.bookmark_add_rounded),
                //update the bookmark text accordingly
                label: Text(
                  widget.news.isBookmarked ? "Bookmarked" : "Bookmark",
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                )
              ),
              //this is the button to share the news
              ElevatedButton.icon(
                //call the share function in the news class when the button is pressed
                onPressed: widget.news.shareNews,
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
          //this is the button to visit the website
          ElevatedButton.icon(
            //call the visitWebsite function in the news class when the button is pressed
            onPressed: widget.news.visitWebsite,
            style: ButtonStyle(
              fixedSize: WidgetStateProperty.all(const Size(double.maxFinite, 50))
            ),
            icon: const Icon(Icons.launch_rounded),
            label: const Text(
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