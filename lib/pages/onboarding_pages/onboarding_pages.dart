import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';


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
                  '1. Report Issues: If you encounter any unexpected behavior, glitches, or errors while using the app, please inform us promptly. You can do this by accessing the "Contact Developer" option in the app\'s menu.\n\n'
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


class DataSelectionPage extends StatefulWidget {
  final Function() nextScreen;
  const DataSelectionPage({
    super.key,
    required this.nextScreen,
  });

  @override
  State<DataSelectionPage> createState() => _DataSelectionPageState();
}

class _DataSelectionPageState extends State<DataSelectionPage> {
  String? country = UserSettings.getSelectedCountry();
  List<String> selectedTopics = UserSettings.getUserFavourites() ?? [];


 final List<String> allTopics = [
  'Technology',
  'Health',
  'Sports',
  'Entertainment',
  'Science',
  'Travel',
  'Food',
  'Fashion',
  'Music',
  'Finance',
  'Education',
  'Gaming',
  'Art',
  'Environment',
  'Books',
  'Fitness',
  'Pets',
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Country:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showCountryPicker(
                  context: context,
                  onSelect: (country) {
                    setState(() {
                      this.country = country.name;
                    });
                  },
                );
              },
              icon: const Icon(Icons.flag),
              label: Text(
                country ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select at least three Favorite Topics:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allTopics.length,
                itemBuilder: (context, index) {
                  final String topic = allTopics[index];
                  return CheckboxListTile(
                    title: Text(topic),
                    value: selectedTopics.contains(topic),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedTopics.add(topic);
                        } else {
                          selectedTopics.remove(topic);
                        }
                      });
                    },
                  );
                }
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (country != null && selectedTopics.length >= 3) {
                    UserSettings.setSelectedCountry(country!);
                    UserSettings.setUserFavourites(selectedTopics);
                    widget.nextScreen();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please select a country and at least three favorite topics.'),
                    ));
                  }
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}