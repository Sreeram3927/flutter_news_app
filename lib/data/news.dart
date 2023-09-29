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
    image = imageURL == null ? null : NetworkImage('$baseRelativeURL$imageURL');
    authorLogo = authorLogoURL == null ? null : NetworkImage('$baseRelativeURL$authorLogoURL');
    authorBigLogo = authorBigLogoURL == null ? null : NetworkImage('$baseRelativeURL$authorBigLogoURL');
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

  Widget newsOutletLogo(double radius) {
    if (authorLogo != null) {
      return CircleAvatar(
        backgroundImage: authorLogo,
        radius: radius,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void additionalInfo(BuildContext context) {
    showModalBottomSheet(
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