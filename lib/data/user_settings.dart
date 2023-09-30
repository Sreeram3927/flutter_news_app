import 'dart:convert';

import 'package:news_watch/data/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  
  static late SharedPreferences _prefs;
  static Future<void> localStorageInit() async {
    _prefs = await SharedPreferences.getInstance();
  }
  static Future<void> clearLocalStorage() async {
    await _prefs.clear();
  }

  static Future<void> setShowHome(bool value) async {
    await _prefs.setBool('showHome', value);
  }
  static getShowHome() {
    return _prefs.getBool('showHome');
  }

  static Future<void> setDarkMode(bool value) async {
    await _prefs.setBool('isDarkMode', value);
  }
  static bool getDarkMode() {
    return _prefs.getBool('isDarkMode') ?? false;
  }


  static Future<void> setSelectedCountry(String value) async {
    await _prefs.setString('country', value);
  }
  static String getSelectedCountry() {
    return _prefs.getString('country') ?? 'India';
  }


  static Future<void> setUserFavourites(List<String> value) async {
    await _prefs.setStringList('userFavourites', value);
  }
  static List<String> getUserFavourites() {
    return _prefs.getStringList('userFavourites') ?? [
      'Space',
      'Technology',
      'Science',
      'Programming',
    ];
  }


  static Future<void> saveBookmarks(List<News> bookmarks) async {
    final encodedList = bookmarks.map((item) => jsonEncode(item.toJson())).toList();
    _prefs.setStringList('bookmarks', encodedList);
  }
  static List<News> getBookmarks() {
    final encodedList = _prefs.getStringList('bookmarks') ?? [];
    return encodedList.map((item) => News.fromJson(jsonDecode(item))).toList();
  }
}
