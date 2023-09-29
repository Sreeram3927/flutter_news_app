import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/pages/settings/settings_functions.dart';
import 'package:news_watch/widgets/top_bar.dart';

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
                title: const Text('Dark Mode'),
                leading: const Icon(Icons.dark_mode),
                trailing: Switch(
                  value: UserSettings.getDarkMode(),
                  onChanged: (value) {
                    setState(() {
                      UserSettings.setDarkMode(value);
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('Manage Favourites'),
                leading: const Icon(Icons.favorite_rounded),
                onTap: () {
                  
                },
              ),

              ListTile(
                title: const Text('Help'),
                leading: const Icon(Icons.help_rounded),
                onTap:() {
                  
                },
              ),

              ListTile(
                title: const Text('Source Code'),
                leading: const Icon(Icons.code_rounded),
                onTap: () {
                  
                },
              ),

              ListTile(
                title: const Text('Open Source Licenses'),
                leading: const Icon(Icons.gavel_rounded),
                onTap: () {
                  
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bookmarks cleared'),
                      ),
                    );
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