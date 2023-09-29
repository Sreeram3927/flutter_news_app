import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/web_scraper.dart';

class Favourites {
  final String name;
  late List<News> data;

  Favourites({
    required this.name,
  });

  Future<List<News>> getData() async {
    try {
      print('Getting data for $name');
      data = await BingScraper.getData(name);
      return data;
    } catch (e) {
      print(e);
      return [];
    }
      
  }
}