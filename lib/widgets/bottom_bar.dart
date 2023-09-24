import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 10,
      tabs: [
        GButton(icon: Icons.home_outlined, text: 'Home'),
        GButton(icon: Icons.search_outlined, text: 'Search'),
        GButton(icon: Icons.bookmark_outline_rounded, text: 'Bookmarks'),
        GButton(icon: Icons.settings_outlined, text: 'Settings'),
      ]
    );
  }
}