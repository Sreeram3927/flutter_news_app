import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class BingScraper {

  static String baseURL = 'https://www.bing.com/news/';

  static String baseRelativeURL = 'https://th.bing.com';

  static void getData() async {
    print('starting to load the website...');

    try {
      final response = await http.get(Uri.parse('${baseURL}search?q=Trending+India')).timeout(const Duration(seconds: 10));
      // print(response.body);
      if (response.statusCode == 200) {
        final document = parse(response.body);
        // print(document);
        final elements = document.querySelectorAll('div.news-card'); 
        // print('elements: ${elements[0].querySelector('span[aria-label]')?.text}');


        for (var element in elements) {
          final imageSrc = element.querySelector('div.image.right img')?.attributes['src'];
          final title = element.attributes['data-title'];
          final author = element.attributes['data-author'];
          String? authorLogo;
          String? authorBigLogo;
          if (element.querySelector('div.source.biglogo.set_top') != null) {
            authorBigLogo = element.querySelector('div.caption_img img')?.attributes['src'];
          } else {
            authorLogo = element.querySelector('div.publogo img')?.attributes['src'];
          }
          final url = element.attributes['data-url'];
          final content = element.querySelector('div.snippet')?.attributes['title'];
          final timeAgo = element.querySelector('span[aria-label]')?.text;


          print('Image Source: $imageSrc');
          print('Title: $title');
          print('Author: $author');
          print('Author Logo: $authorLogo');
          print('Author Big Logo: $authorBigLogo');
        // //   print('Author Image: $authorImage');
        // //   print('Author Icon: $authorIcon');
          print('URL: $url');
          print('Snippet: $content');
          print('Time Ago: $timeAgo');
          print('--------------------------------------');
        }
      // } else {
      //   print('Failed to load the website: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    
  }

}