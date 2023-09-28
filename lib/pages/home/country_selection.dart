import 'package:flutter/material.dart';
import 'package:news_watch/widgets/top_bar.dart';


class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TopBar(title: Text('Select Country')),
        ],
      ),
    );
  }
}