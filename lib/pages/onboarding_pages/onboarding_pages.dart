import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';

//this is the first page the user sees
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
                  'Welcome to NewsWatch!', //greet the user
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                //give a introduction to the app
                Text(
                  'Explore the world of news with NewsWatch - Your Ultimate News Companion. We\'re thrilled to have you onboard as a user, and your experience means everything to us.\n\n'
                  'Please note that our app is currently in beta, and there might be some undiscovered quirks and issues. But fret not! Your feedback is invaluable in helping us enhance the app before its official launch.\n\n',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                //tell the user on how to contact the developer
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
          //button to navigate to the next screen
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

//this is the second page the user sees
//here the user select their country and favorite topics
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
  String? country = UserSettings.getSelectedCountry(); //get the previously selected country(for first launch null)
  List<String> selectedTopics = UserSettings.getUserFavourites() ?? []; //get the previously selected topics(for first launch empty list)

  //list of all topics for the user to select favourites from
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
        title: const Text('Preferences'), //title of the page
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //tell the user to select a country
            const Text(
              'Select a Country:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            //button to select a country
            ElevatedButton.icon(
              onPressed: () {
                showCountryPicker(
                  context: context,
                  onSelect: (country) {
                    //update the selected country
                    setState(() {
                      this.country = country.name;
                    });
                  },
                );
              },
              icon: const Icon(Icons.flag),
              label: Text(
                country ?? '', //if country name is null use empty string
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 20),
            //tell the user to select at least three topics as favourites
            const Text(
              'Select at least three Favorite Topics:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allTopics.length,
                itemBuilder: (context, index) {
                  final String topic = allTopics[index];
                  //show all the avaiable topicss inform of checkboxes
                  return CheckboxListTile(
                    title: Text(topic), //topic name
                    value: selectedTopics.contains(topic), //see if the topic is selected by the user or not
                    onChanged: (bool? value) {
                      //change the value of the topic
                      //if the topic is selected add it to the list of selected topics
                      //if the topic is unselected remove it from the list of selected topics
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
            //button to navigate to the next screen
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //check if the user has selected a country and at least three topics
                  if (country != null && selectedTopics.length >= 3) {
                    UserSettings.setSelectedCountry(country!); //update the selected country
                    UserSettings.setUserFavourites(selectedTopics); //update the selected topics
                    widget.nextScreen(); //navigate to the next screen
                  } else { //if the user has not selected a country or at least three topics show a warning snackbar
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