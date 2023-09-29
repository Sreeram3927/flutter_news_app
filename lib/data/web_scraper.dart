import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/user_settings.dart';

class BingScraper {

  static String baseURL = 'https://www.bing.com/news/';

  static Future<List<News>> getData(String query) async {

    List<News> data = [];

    try {
      final response = await http.get(Uri.parse('${baseURL}search?q=$query ${UserSettings.getSelectedCountry()}')).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final document = parse(response.body);
        final elements = document.querySelectorAll('div.news-card');

        for (var element in elements) {
          data.add(
            News(
              title: element.attributes['data-title'] ?? 'Error in title',
              content: element.querySelector('div.snippet')?.attributes['title'] ?? 'Error in content',
              author: element.attributes['data-author'] ?? 'Error in author',
              imageURL: element.querySelector('div.image.right img')?.attributes['src'],
              authorLogoURL: element.querySelector('div.publogo img')?.attributes['src'],
              authorBigLogoURL: element.querySelector('div.caption_img img')?.attributes['src'],
              webURL: element.attributes['data-url'] ?? 'Error in webURL',
              timeAgo: element.querySelector('span[aria-label]')?.text ?? '',
            )
          );
        } 

        // for (var element in elements) {
        //   final imageSrc = element.querySelector('div.image.right img')?.attributes['src'];
        //   final title = element.attributes['data-title'];
        //   final author = element.attributes['data-author'];
        //   String? authorLogo;
        //   String? authorBigLogo;
        //   // if (element.querySelector('div.source.biglogo.set_top') != null) {
        //     authorBigLogo = element.querySelector('div.caption_img img')?.attributes['src'];
        //   // } else {
        //     authorLogo = element.querySelector('div.publogo img')?.attributes['src'];
        //   // }
        //   final url = element.attributes['data-url'];
        //   final content = element.querySelector('div.snippet')?.attributes['title'];
        //   final timeAgo = element.querySelector('span[aria-label]')?.text;


        //   print('Image Source: $imageSrc');
        //   print('Title: $title');
        //   print('Author: $author');
        //   print('Author Logo: $authorLogo');
        //   print('Author Big Logo: $authorBigLogo');
        // //   print('Author Image: $authorImage');
        // //   print('Author Icon: $authorIcon');
        //   print('URL: $url');
        //   print('Snippet: $content');
        //   print('Time Ago: $timeAgo');
        //   print('--------------------------------------');
        // }
        // for (var news in data) {
        //   print(news.title);
        //   print(news.content);
        //   print(news.imageURL);
        //   print(news.author);
        //   print(news.authorLogoURL);
        //   print(news.authorBigLogoURL);
        //   print(news.webURL);
        //   print(news.timeAgo);
        //   print('--------------------------------------');
        // }
        return data;
      } else {
        print('Failed to load the website: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    
  }

}