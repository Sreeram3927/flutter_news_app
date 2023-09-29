import 'package:news_watch/data/favourites.dart';
import 'package:news_watch/data/news.dart';

class UserSettings {

  static String selectedCountry = 'India';

  static bool isDarkMode = false;

  static List<Favourites> userFavourites = [
    Favourites(name: 'Space'),
    Favourites(name: 'Technology'),
    Favourites(name: 'Science'),
    Favourites(name: 'Programming'),
  ];

  static List<News> bookmarks = [];

}