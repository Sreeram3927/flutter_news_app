import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:news_watch/data/news.dart';
import 'package:news_watch/data/user_settings.dart';


//this app uses bing news to get the news data
//it dosent use any api but instead relies on 
//scraping data from the search results page
class BingScraper {

  //the base url of the bing news website
  static String baseURL = 'https://www.bing.com/news/';

  //this function is used to get the news data from the web
  //and it returns a list of news objects
  //it takes in a query string and a bool to add the country to the query string
  static Future<List<News>> getData({required String query, bool addCountry = false}) async {

    List<News> data = []; //innilitize an empty list of news

    //if addCountry is true, then add the country to the query string
    if (addCountry) {
      query += ' ${UserSettings.getSelectedCountry()}';
    }
    //try to get the data from the web
    try {
      //send a http get request to bing news search
      //and it waits for 10s for the response
      //if it dosent get a response within 10s, it throws an timeout exception
      final response = await http.get(Uri.parse('${baseURL}search?q=$query')).timeout(const Duration(seconds: 10));
      
      //if the response is successful, proceed with scraping the data
      if (response.statusCode == 200) {
        final document = parse(response.body); //parse the html response
        //all the news data is stored in div with class news-card
        //so we get all the divs with class news-card as a list
        final elements = document.querySelectorAll('div.news-card'); 

        //cycle though the list and get the data from each div
        //and add it to the data list as a news object
        for (var element in elements) {
          data.add( //add the news object to the data list
            News(
              title: element.attributes['data-title'] ?? 'Error in title', //check for the title in the div
              content: element.querySelector('div.snippet')?.attributes['title'] ?? 'Error in content', //check for the content in the div
              author: element.attributes['data-author'] ?? 'Error in author', //check for the author in the div
              authorLogoURL: element.querySelector('div.publogo img')?.attributes['src'], //check for the author logo(small) in the div
              authorBigLogoURL: element.querySelector('div.caption_img img')?.attributes['src'], //check for the author logo(big) in the div
              imageURL: element.querySelector('div.image.right img')?.attributes['src'], //check for the image in the div
              webURL: element.attributes['data-url'] ?? 'Error in webURL', //check for the url of the news in the div
              timeAgo: element.querySelector('span[aria-label]')?.text ?? '', //check for the time ago in the span
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
        return data; //return the data list
      } else {
        // print('Failed to load the website: ${response.statusCode}');
        return []; //return an empty list if the response is not successful
      }
    } catch (e) {
      print(e);
      rethrow; //rethrow the exception, if caught any
    }
    
  }

}