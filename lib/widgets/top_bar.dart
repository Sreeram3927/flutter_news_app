import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('News Watch'),
      actions: [
        
        Center(child: Text('India')),

        IconButton(
          icon: const Icon(Icons.location_pin),
          onPressed: () {},
        ),

      ]
    );
  }
}