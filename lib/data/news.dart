class News {
  final String title;
  final String content;
  final String newsOutlet;
  final String timeAgo;
  String? imageUrl;
  String? newsOutletLogoUrl;

  News({
    required this.title,
    required this.content,
    required this.newsOutlet,
    required this.timeAgo,
    this.imageUrl,
    this.newsOutletLogoUrl,
  });

}