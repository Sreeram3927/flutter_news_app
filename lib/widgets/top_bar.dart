import 'package:flutter/material.dart';

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
    return SliverAppBar(
      floating: true,
      snap: true,
      toolbarHeight: 56,
      title: title,
      actions: actions,
      leading: leading,
    );
  }
}