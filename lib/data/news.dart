import 'package:flutter/material.dart';
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
    image = imageURL == null ? null : NetworkImage(imageURL!);
    authorLogo = authorLogoURL == null ? null : NetworkImage(authorLogoURL!);
    authorBigLogo = authorBigLogoURL == null ? null : NetworkImage(authorBigLogoURL!);
  }

  late final NetworkImage? image;
  late final NetworkImage? authorLogo;
  late final NetworkImage? authorBigLogo;

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

}