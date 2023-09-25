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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent[100]!, width: 1,),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: GNav(
        color: Colors.grey.shade600,
        activeColor: Colors.black,
        rippleColor: Colors.blue[200]!,
        tabBackgroundGradient: LinearGradient(
          colors: [Colors.blue[300]!, Colors.blue[100]!],
        ),
        tabBorderRadius: 20,
        padding: const EdgeInsets.all(16),
        gap: 10,
        selectedIndex: _selectedIndex,
        onTabChange: _changeScreen,
        duration: const Duration(milliseconds: 300),
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: 'Home',
            active: _selectedIndex == 0,
          ),
          GButton(
            icon: Icons.search_outlined,
            text: 'Search',
            active: _selectedIndex == 1,
          ),
          GButton(
            icon: Icons.bookmark_outline_rounded,
            text: 'Bookmarks',
            active: _selectedIndex == 2,
          ),
          GButton(
            icon: Icons.settings_outlined,
            text: 'Settings',
            active: _selectedIndex == 3,
          ),
        ]
      ),
    );
  }
}