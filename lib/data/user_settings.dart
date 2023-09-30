import 'dart:convert';
import 'package:news_watch/data/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  
  //shared preferences is used to store the user settings locally
  static late SharedPreferences _prefs;
  //this function is called when the app starts to initialize the shared preferences
  static Future<void> localStorageInit() async {
    _prefs = await SharedPreferences.getInstance();
  }
  //this function is used to clear the all daata stored locally by the app
  static Future<void> clearLocalStorage() async {
    await _prefs.clear();
  }
  
  //this function is used to store first launch of the user
  static Future<void> setShowHome(bool value) async {
    await _prefs.setBool('showHome', value);
  }
  //this function is used to check if the user has launched the app already or not
  static getShowHome() {
    return _prefs.getBool('showHome');
  }

  //this function is used to store the selected country of the user
  static Future<void> setSelectedCountry(String value) async {
    await _prefs.setString('country', value);
  }
  //this function is used to get the selected country of the user
  static String? getSelectedCountry() {
    return _prefs.getString('country');
  }

  //this function is used to store the favourite topics of the user
  static Future<void> setUserFavourites(List<String> value) async {
    await _prefs.setStringList('userFavourites', value);
  }
  //this function is used to get the favourite topics of the user
  static List<String>? getUserFavourites() {
    return _prefs.getStringList('userFavourites');
  }

  //this function is used to store the bookmarks of the user
  static Future<void> saveBookmarks(List<News> bookmarks) async {
    final encodedList = bookmarks.map((item) => jsonEncode(item.toJson())).toList();//convert the news to json format
    _prefs.setStringList('bookmarks', encodedList);
  }
  //this function is used to get the bookmarks of the user
  static List<News> getBookmarks() {
    final encodedList = _prefs.getStringList('bookmarks') ?? [];
    return encodedList.map((item) => News.fromJson(jsonDecode(item))).toList(); //convert the json to news format
  }
}
