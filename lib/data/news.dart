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

}