import 'package:flutter/material.dart';

//this is the app bar of the app/widgets
class TopBar extends StatelessWidget {
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;
  const TopBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    //use sliverAppBar if parent widget requires a sliver
    return SliverAppBar(
      floating: true, //make the app bar floating
      snap: true, //make the app bar snap when the user scrolls
      toolbarHeight: 56, //set the height of the app bar
      title: title, //set the title of the app bar
      actions: actions, //set the actions of the app bar if any
      leading: leading, //set the leading widget of the app bar if any
    );
  }
}