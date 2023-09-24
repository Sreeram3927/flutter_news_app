import 'package:flutter/material.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'News Title',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'News Description',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Image(
              image: NetworkImage('https://th.bing.com/th?id=OVFT.gqBmAH9mIZraTqwv8FOKVS&pid=News&w=234&h=132&c=14&rs=2&qlt=90&dpr=1.3'),
              fit: BoxFit.fitHeight,
              width: 145,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}