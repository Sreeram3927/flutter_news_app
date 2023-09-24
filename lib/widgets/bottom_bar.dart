import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatefulWidget {
  final Function(int) changePage;
  const BottomBar({super.key, required this.changePage});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _selectedIndex = 0;

  void _changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 10,
      selectedIndex: _selectedIndex,
      onTabChange: _changeScreen,
      tabs: const [
        GButton(
          icon: Icons.home_outlined,
          text: 'Home'
        ),
        GButton(
          icon: Icons.search_outlined,
          text: 'Search'
        ),
        GButton(
          icon: Icons.bookmark_outline_rounded,
          text: 'Bookmarks'
        ),
        GButton(
          icon: Icons.settings_outlined,
          text: 'Settings'
        ),
      ]
    );
  }
}