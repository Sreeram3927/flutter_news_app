import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/widgets/news_card.dart';

class News {
  final String title;
  final String content;
  final String author;
  final String timeAgo;
  final String webURL;
  final String? imageURL;
  final String? authorLogoURL;
  final String? authorBigLogoURL;
  bool isBookmarked;

  late final NetworkImage? image;
  late final NetworkImage? authorLogo;
  late final NetworkImage? authorBigLogo;

  String baseRelativeURL = 'https://th.bing.com';

  News({
    required this.title,
    required this.content,
    required this.author,
    required this.timeAgo,
    required this.webURL,
    this.imageURL,
    this.authorLogoURL,
    this.authorBigLogoURL,
    this.isBookmarked = false,
  }){
    image = imageURL == null ? null : fromNetwork(imageURL!);
    authorLogo = authorLogoURL == null ? null : fromNetwork(authorLogoURL!);
    authorBigLogo = authorBigLogoURL == null ? null : fromNetwork(authorBigLogoURL!);
  }

  NetworkImage? fromNetwork(String url) {
    if (url.contains('bing')){
      return NetworkImage(url);
    } else {
      return NetworkImage('$baseRelativeURL$url');
    }
  }

  Widget newsImage({double? height, required double width}) {
    if (image != null) {
      return Image(
        image: image!,
        fit: BoxFit.fitHeight,
        width: width,
        height: height,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget aboutAuthor({
    required double radius,
    required double width,
    required double height,
    required double fontSize,
  }) {

    List<Widget> topPart = [];
    
    if (authorLogo != null) {
      topPart.add(CircleAvatar(
        backgroundImage: authorLogo,
        radius: radius,
      ));
      topPart.addAll([
        const SizedBox(width: 6),
        SizedBox(
          width: 100,
          child: Text(
            author,
            style: TextStyle(
              fontSize: fontSize
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]);
    } else if (authorBigLogo != null) {
      topPart.add(Image(
        image: authorBigLogo!,
        width: width,
        height: height,
      ));
    } else {
      topPart.add(const SizedBox.shrink());
    }
    
    topPart.add(Text(
      " | $timeAgo",
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.grey,
      ),
    ));

    return Row(children: topPart);
  }

  Future<void> additionalInfo(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return NewsCard(news: this);
      }
    );
  }

  void bookmark() {
    final bookmarks = UserSettings.getBookmarks();
    if (isBookmarked) {
      isBookmarked = false;
      bookmarks.removeWhere((item) {
        return item.webURL == webURL;
      });
    } else {
      isBookmarked = true;
      bookmarks.add(this);
    }
    UserSettings.saveBookmarks(bookmarks);
  }

  Map<String, dynamic> toJson() => {
    'title' : title,
    'content' : content,
    'author' : author,
    'timeAgo' : timeAgo,
    'webURL' : webURL,
    'imageURL' : imageURL,
    'authorLogoURL' : authorLogoURL,
    'authorBigLogoURL' : authorBigLogoURL,
    'isBookmarked' : isBookmarked,
  };

  factory News.fromJson(Map<String, dynamic> json) {
  return News(
    title: json['title'] as String,
    content: json['content'] as String,
    author: json['author'] as String,
    timeAgo: json['timeAgo'] as String,
    webURL: json['webURL'] as String,
    imageURL: json['imageURL'] as String?,
    authorLogoURL: json['authorLogoURL'] as String?,
    authorBigLogoURL: json['authorBigLogoURL'] as String?,
    isBookmarked: json['isBookmarked'] as bool,
  );
}
}