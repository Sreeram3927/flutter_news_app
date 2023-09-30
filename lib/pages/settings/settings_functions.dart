import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';

Widget clearBookmarks(BuildContext context) {
  return AlertDialog(
    title: const Text('Clear Bookmarks'),
    content: const Text('Are you sure you want to clear your bookmarks?'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop('cancel');
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          UserSettings.saveBookmarks([]);
          Navigator.of(context).pop('clear');
        },
        child: const Text('Clear'),
      ),
    ],
  );
}

Widget clearData(BuildContext context) {
  return AlertDialog(
    title: const Text('Clear All Data'),
    content: const Text('Are you sure you want to clear all data?\nThis will close the app.'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop('cancel');
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          UserSettings.clearLocalStorage();
          Navigator.of(context).pop('clear');
        },
        child: const Text('Clear'),
      ),
    ],
  );
}