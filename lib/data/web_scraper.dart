import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class BingScraper {

  static void getData() async {
    print('starting to load the website...');

    try {
      final response = await http.get(Uri.parse('https://www.bing.com/news/search?q=Trending+India')).timeout(const Duration(seconds: 10));
      // print(response.body);
      if (response.statusCode == 200) {
        final document = parse(response.body);
        // print(document);
        final elements = document.querySelectorAll('.news-card[data-title]'); 
        print('elements: $elements');

        for (var element in elements) {
          final title = element.attributes['data-title'];
          final author = element.attributes['data-author'];
          final url = element.attributes['url'];

          print('Title: $title');
          print('Author: $author');
          print('URL: $url');
          print('-----------------------');
            }
      // } else {
      //   print('Failed to load the website: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    
  }

}