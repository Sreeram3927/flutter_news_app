import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:url_launcher/url_launcher.dart';

//this widget is used to confirm and clear the saved bookmarks
Widget clearBookmarks(BuildContext context) {
  return AlertDialog(
    title: const Text('Clear Bookmarks'),
    //ask the to confirm the clear bookmarks action
    content: const Text('Are you sure you want to clear your bookmarks?'),
    actions: [
      //give them an option cancel the operation
      TextButton(
        onPressed: () {
          Navigator.of(context).pop('cancel');
        },
        child: const Text('Cancel'),
      ),
      //give them an option to confirm the operation
      TextButton(
        onPressed: () {
          UserSettings.saveBookmarks([]);
          Navigator.of(context).pop('clear'); //send a confirm message to the parent widget
        },
        child: const Text('Clear'),
      ),
    ],
  );
}

//this widget is used to confirm and clear the saved data
Widget clearData(BuildContext context) {
  return AlertDialog(
    title: const Text('Clear All Data'),
    //ask the to confirm the clear data action
    content: const Text('Are you sure you want to clear all data?\nThis will close the app.'),
    actions: [
      //give them an option cancel the operation
      TextButton(
        onPressed: () {
          Navigator.of(context).pop('cancel');
        },
        child: const Text('Cancel'),
      ),
      //give them an option to confirm the operation
      TextButton(
        onPressed: () {
          UserSettings.clearLocalStorage();
          Navigator.of(context).pop('clear'); //send a confirm message to the parent widget
        },
        child: const Text('Clear'),
      ),
    ],
  );
}

//this widget is used to display the developecontact informations
Widget contactDeveloper() {

  //list of ways to contact the developer
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
      //display the contact options in the list
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
                //launch the selected method is web browser
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