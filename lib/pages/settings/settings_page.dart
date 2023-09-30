import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_watch/pages/onboarding_pages/onboarding_pages.dart';
import 'package:news_watch/pages/settings/settings_functions.dart';
import 'package:news_watch/widgets/top_bar.dart';
import 'package:url_launcher/url_launcher.dart';

//this page allow the user to manipulate the app's settings
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //this is the appbar of the widget
        const TopBar(
          title: Text("Settings"), //set the title to settings
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              //this options allows the user to select the all preferences
              ListTile(
                title: const Text('Manage Preferences'),
                leading: const Icon(Icons.favorite_rounded),
                onTap: () async {
                  //when the user taps on the option, navigate to the data selection page
                  final data = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return DataSelectionPage(
                          //set the nextpage to come back to this page
                          nextScreen: () => Navigator.pop(context, 'changed'),
                        );
                      },
                      //animate the transition to the next page
                      //this animation slides the page from the bottom to the top
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    )
                  );
                  //check if the user had changed any data
                  if (data == 'changed') {
                    //if yes show a snackbar notifying the user 
                    //that the preferences have been updated
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preferences Updated'),
                      ),
                    );
                  }
                },
              ),

              //this option allows the user to contact the developer
              ListTile(
                title: const Text('Contact Developer'),
                leading: const Icon(Icons.headset_mic_rounded),
                onTap:() {
                  //when the user taps on the option
                  ////show a dialog with the developer's contact details
                  showDialog(context: context, builder: (context) => contactDeveloper());
                },
              ),

              //this option allows the user to view the source code of the app
              ListTile(
                title: const Text('Source Code'),
                leading: const Icon(Icons.code_rounded),
                onTap: () async {
                  //when the user taps on the option
                  //launch the source code url in the in app webview
                  final url = Uri.parse('https://github.com/Sreeram3927/flutter_news_app');
                  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
              
              //this option allows the user to view the open source licenses
              //this licenses of the packages used in creation of this app
              ListTile(
                title: const Text('Open Source Licenses'),
                leading: const Icon(Icons.gavel_rounded),
                onTap: () {
                  //when the user taps on the option
                  //navigate to the license page
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        //the LicensePage page is an existing widget that shows all
                        //the licenses of the packages used in the app
                        return const LicensePage( 
                          applicationName: 'News Watch', //set the application name
                          applicationVersion: '1.0.0',  //set the application version 
                        );
                      },
                      //animate the transition to the next page
                      //this animation slides the page from the bottom to the top
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    )
                  );
                },
              ),

              //this option allows the user to clear the saved bookmarks
              ListTile(
                title: const Text('Clear Bookmarks'),
                //show it in red colour
                textColor: Colors.red,
                leading: const Icon(Icons.delete_rounded, color: Colors.red,),
                onTap: () async {
                  //when the user taps on the option
                  //show  a dialog to confirm the action
                  final data = await showDialog(
                    context: context,
                    builder: clearBookmarks,
                  );
                  //check if the user has confirmed the action
                  if (data == 'clear') {
                    //if yes tell them the bookmarks have been cleared
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bookmarks cleared'),
                      ),
                    );
                  }
                },
              ),

              //this option allows the user to clear the saved data
              ListTile(
                title: const Text('Clear Data'),
                //show it in red colour
                textColor: Colors.red,
                leading: const Icon(Icons.delete_forever_rounded, color: Colors.red,),
                onTap: () async {
                  //when the user taps on the option
                  //show a dialog to confirm the action
                  final data = await showDialog(
                    context: context,
                    builder: clearData,
                  );
                  //check if the user has confirmed the action
                  if (data == 'clear') {
                    //if yes tell close the app for a fresh nwe start
                    SystemNavigator.pop();
                  }
                },
              ),
              
              //this is just an information about the
              //app naem and version
              const ListTile(
                title: Center(child: Text('News watch')),
                subtitle: Center(child: Text('Version 1.0.0')),
              ),
            ]
          )
        )
      ],
    );
  }
}