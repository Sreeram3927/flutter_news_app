import 'package:flutter/material.dart';
import 'package:news_watch/widgets/top_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}