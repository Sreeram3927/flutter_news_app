import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_watch/pages/onboarding_pages/onboarding_pages.dart';
import 'package:news_watch/pages/settings/settings_functions.dart';
import 'package:news_watch/widgets/top_bar.dart';
import 'package:url_launcher/url_launcher.dart';

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
        const TopBar(
          title: Text("Settings"),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [

              ListTile(
                title: const Text('Manage Preferences'),
                leading: const Icon(Icons.favorite_rounded),
                onTap: () async {
                  final data = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return DataSelectionPage(
                          nextScreen: () => Navigator.pop(context, 'changed'),
                        );
                      },
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
                  if (data == 'changed') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preferences Updated'),
                      ),
                    );
                  }
                },
              ),

              ListTile(
                title: const Text('Contact Developer'),
                leading: const Icon(Icons.headset_mic_rounded),
                onTap:() {
                  showDialog(context: context, builder: (context) => contactDeveloper());
                },
              ),

              ListTile(
                title: const Text('Source Code'),
                leading: const Icon(Icons.code_rounded),
                onTap: () async {
                  final url = Uri.parse('https://github.com/Sreeram3927/flutter_news_app');
                  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),

              ListTile(
                title: const Text('Open Source Licenses'),
                leading: const Icon(Icons.gavel_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const LicensePage(
                          applicationName: 'News Watch',
                          applicationVersion: '1.0.0',
                        );
                      },
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

              ListTile(
                title: const Text('Clear Bookmarks'),
                textColor: Colors.red,
                leading: const Icon(Icons.delete_rounded, color: Colors.red,),
                onTap: () async {
                  final data = await showDialog(
                    context: context,
                    builder: clearBookmarks,
                  );
                  if (data == 'clear') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bookmarks cleared'),
                      ),
                    );
                  }
                },
              ),

              ListTile(
                title: const Text('Clear Data'),
                textColor: Colors.red,
                leading: const Icon(Icons.delete_forever_rounded, color: Colors.red,),
                onTap: () async {
                  final data = await showDialog(
                    context: context,
                    builder: clearData,
                  );
                  if (data == 'clear') {
                    SystemNavigator.pop();
                  }
                },
              ),

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