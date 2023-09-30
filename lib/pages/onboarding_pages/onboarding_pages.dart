import 'package:flutter/material.dart';


class WelcomePage extends StatelessWidget {
  final void Function() nextScreen;
  const WelcomePage({
    super.key,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                Text(
                  'Welcome to NewsWatch!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Explore the world of news with NewsWatch - Your Ultimate News Companion. We\'re thrilled to have you onboard as a user, and your experience means everything to us.\n\n'
                  'Please note that our app is currently in beta, and there might be some undiscovered quirks and issues. But fret not! Your feedback is invaluable in helping us enhance the app before its official launch.\n\n',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Here\'s how you can assist us in improving:\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  '1. Report Issues: If you encounter any unexpected behavior, glitches, or errors while using the app, please inform us promptly. You can do this by accessing the "Feedback" or "Contact Us" option in the app\'s menu.\n\n'
                  '2. Share Your Suggestions: Do you have ideas for new features or improvements? We\'re all ears! Your valuable suggestions can shape the future of our app, making it more tailored to your preferences.\n\n'
                  '3. User Experience Matters: Your app experience matters to us. If you find any aspects confusing or challenging to navigate, please let us know so we can enhance the user interface for everyone.\n\n',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
            ),
            onPressed: nextScreen,
            child: const Text('Continue'),
          )
        ],
      ),
    );
  }
}