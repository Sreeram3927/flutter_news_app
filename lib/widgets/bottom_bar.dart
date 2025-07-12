import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


//this is the bottom navigation bar of the app
class BottomBar extends StatefulWidget {
  final Function(int) changePage;
  const BottomBar({super.key, required this.changePage});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  //this is the index of the selected page
  //initially set it to zero
  int _selectedIndex = 0; 

  //this function us used to update the selected page
  void _changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //call the changePage function in the parent widget to change the page
    widget.changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.blueAccent[100]!, width: 1),
          left: BorderSide(color: Colors.blueAccent[100]!, width: 1),
          right: BorderSide(color: Colors.blueAccent[100]!, width: 1),
          //this bottom border is added to prevent the following error
          //The following assertion was thrown during paint():
          //A borderRadius can only be given on borders with uniform colors and styles.
          bottom: BorderSide(color: Colors.blueAccent[100]!.withValues(alpha: 1.0), width: 1),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: GNav(
        color: Colors.grey.shade600, //set the color of the text
        activeColor: Colors.black,  //set the color of the selected text
        rippleColor: Colors.blue[200]!, //this color rippes when the user taps on the tab
        tabBackgroundGradient: LinearGradient(
          //set the gradient of the selected tab background
          colors: [Colors.blue[300]!, Colors.blue[100]!],
        ),
        tabBorderRadius: 20,
        padding: const EdgeInsets.all(16),
        gap: 10, //padding between the tabs
        selectedIndex: _selectedIndex, //set the selected tab to the selected index
        onTabChange: _changeScreen, //call the _changeScreen function when the user taps on a tab
        duration: const Duration(milliseconds: 300), //set the animation duration
        tabs: [
          //create a home tab for home page
          GButton(
            icon: Icons.home_outlined,
            text: 'Home',
            active: _selectedIndex == 0,
          ),
          //create a search tab for search page
          GButton(
            icon: Icons.search_outlined,
            text: 'Search',
            active: _selectedIndex == 1,
          ),
          //create a bookmarks tab for bookmarks page
          GButton(
            icon: Icons.bookmark_outline_rounded,
            text: 'Bookmarks',
            active: _selectedIndex == 2,
          ),
          //create a settings tab for settings page
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