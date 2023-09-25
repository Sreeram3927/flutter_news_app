import 'package:flutter/material.dart';

class News {
  final String title;
  final String content;
  final String newsOutlet;
  final String timeAgo;
  final String webUrl;
  String? imageUrl;
  String? newsOutletLogoUrl;

  News({
    required this.title,
    required this.content,
    required this.newsOutlet,
    required this.timeAgo,
    required this.webUrl,
    this.imageUrl,
    this.newsOutletLogoUrl,
  });

  Widget newsImage({double? height, required double width}) {
    if (imageUrl != null) {
      return Image(
        image: NetworkImage(imageUrl!),
        fit: BoxFit.fitHeight,
        width: width,
        height: height,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget newsOutletLogo(double radius) {
    if (newsOutletLogoUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(newsOutletLogoUrl!),
        radius: radius,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

}