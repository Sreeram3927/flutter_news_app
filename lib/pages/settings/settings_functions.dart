import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:url_launcher/url_launcher.dart';

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

Widget contactDeveloper() {

  List contactOptions = [
    [Icons.email, 'devxpert3927@gmail.com', 'mailto:devxpert3927@gmail.com'],
    [FontAwesomeIcons.squareXTwitter, 'X', 'https://www.twitter.com/sreeram3927/'],
    [FontAwesomeIcons.linkedin, 'LinkedIn', 'https://www.linkedin.com/in/sreeram3927/'],
    [FontAwesomeIcons.github, 'GitHub', 'https://github.com/sreeram3927']
  ];

  return AlertDialog(
    title: const Text(
      'Contact Developer',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 21.0,
        fontWeight: FontWeight.w600,
      ),
    ),
    content: Wrap(
      direction: Axis.vertical,
      children: List.generate(contactOptions.length, (index) {
        return Row(
          children: [
            Icon(contactOptions[index][0], size: 25.0,),
            const SizedBox(width: 10.0, height: 50.0,),
            GestureDetector(
              child: Text(
                contactOptions[index][1],
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () async {
                Uri url = Uri.parse(contactOptions[index][2]);
                if (!await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch $url');
                }
              },
            )
          ]
        );
      }),
    ),
  );
}