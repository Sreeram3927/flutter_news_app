import 'package:flutter/material.dart';

class Favourites {
  final String name;
  late List<Widget> list;

  Favourites({
    required this.name,
  }) {
    list = [];
  }
}