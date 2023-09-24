import 'package:flutter/material.dart';

class TrendingNewsFeed extends StatelessWidget {
  const TrendingNewsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [

          Image(
            image: NetworkImage('https://th.bing.com/th?id=OVFT.gqBmAH9mIZraTqwv8FOKVS&pid=News&w=234&h=132&c=14&rs=2&qlt=90&dpr=1.3'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),


          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black], 
                ),
              ),
            ),
          ),


          Positioned(
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://www.bing.com/th?id=ODF.KANCozAEZYO1NwXNST5YDQ&pid=news&w=16&h=16&c=14&rs=2&qlt=90&dpr=1.3'),
                      radius: 7,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "timesnownews",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),
                    ),
                    Text(
                      " | 1h",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  "How to Watch: NASA's OSIRIS-REx Mission Bringing Asteroid Sample Back to Earth After Travelling for 3 Years",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}