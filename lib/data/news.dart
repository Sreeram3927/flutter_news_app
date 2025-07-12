import 'package:flutter/material.dart';
import 'package:news_watch/data/user_settings.dart';
import 'package:news_watch/widgets/news_card.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

//create a new class to store news data
class News {
  final String title;
  final String content;
  final String author;
  final String timeAgo;
  final String webURL; //webURL is always unique as is used as primary key
  final String? imageURL;
  final String? authorLogoURL;
  final String? authorBigLogoURL;
  bool isBookmarked;

  late final NetworkImage? image;
  late final NetworkImage? authorLogo;
  late final NetworkImage? authorBigLogo;

  //when we scrape the news from the web, the image url is relative to the base url
  //so we need to add the base url to the image url to get the full url
  String baseRelativeURL = 'https://th.bing.com';

  News({
    required this.title,
    required this.content,
    required this.author,
    required this.timeAgo,
    required this.webURL,
    this.imageURL,
    this.authorLogoURL,
    this.authorBigLogoURL,
    this.isBookmarked = false,
  }){
    //get the image, authorLogo and authorBigLogo from the web (if available)
    image = imageURL == null ? null : fromNetwork(imageURL!);
    authorLogo = authorLogoURL == null ? null : fromNetwork(authorLogoURL!);
    authorBigLogo = authorBigLogoURL == null ? null : fromNetwork(authorBigLogoURL!);
    //check if the news is already bookmarked or not
    for (var element in UserSettings.getBookmarks()) {
      if (element.webURL == webURL) {
        isBookmarked = true;
        break;
      }
    }
  }

  //this function checks the is webURL full or relative to bing and returns the NetworkImage
  NetworkImage? fromNetwork(String url) {
    if (url.contains('bing')){ //if the url contains bing, then it is full url
      return NetworkImage(url);
    } else { //else it is relative url
      return NetworkImage('$baseRelativeURL$url');
    }
  }

  //this function returns the news image(if available) to be displayed in the news card, etc
  //it takes in the height and width of the image to be displayed
  Widget newsImage({double? height, required double width}) {
    if (image != null) {
      return Image(
        image: image!,
        fit: BoxFit.fitHeight,
        width: width,
        height: height,
      );
    } else { //if the image is not available, return an empty SizedBox
      return const SizedBox.shrink();
    }
  }

  //this function returns the news author logo(if available),
  //name, timeago of the news to be displayed in the news card, etc.
  //there are two kinds of author logo, one is small and other is big
  //so we need to check which one is available and uses it accordingly
  Widget aboutAuthor({
    required double radius, //radius for small logo
    required double width, //width for big logo
    required double height, //height for big logo
    required double fontSize, //font size for author name and timeago
  }) {

    List<Widget> topPart = [];
    
    //if small author logo is available, it uses logo and author name
    if (authorLogo != null) {
      topPart.add(CircleAvatar(
        backgroundImage: authorLogo,
        radius: radius,
      ));
      topPart.addAll([
        const SizedBox(width: 6),
        SizedBox(
          width: 100,
          child: Text(
            author,
            style: TextStyle(
              fontSize: fontSize
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]);
    //if big logo is available it uses the logo only
    } else if (authorBigLogo != null) {
      topPart.add(Image(
        image: authorBigLogo!,
        width: width,
        height: height,
      ));
    //if no logo is available, it returns an empty SizedBox
    } else {
      topPart.add(const SizedBox.shrink());
    }
    
    //the time ago is always displayed
    topPart.add(Text(
      " | $timeAgo",
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.grey,
      ),
    ));

    return Row(children: topPart); //returns the top part as a row
  }

  //this function returns the news title, content, etc and as a ModalBottomSheet
  Future<void> additionalInfo(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true, //use safe to avoid the bottom sheet from overlapping with device infos(bettery, time, etc)
      isScrollControlled: true, //allow the bottom sheet to be scrollable by user
      builder: (context) {
        return NewsCard(news: this); //returns the news card
      }
    );
  }

  //this function shares the news with other social media apps
  Future<void> shareNews() async {
    final SharePlus shareService = SharePlus.instance;
    await shareService.share(ShareParams(title: title, text: webURL)); //shares the title and webURL of the news as text format
  }

  //this function opens the news(webURL) in the inAppWebView
  Future<void> visitWebsite() async {
    Uri url = Uri.parse(webURL);
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  //this function bookmarks the news, if its not bookmarked
  //and unbookmarks the news, if its already bookmarked
  void bookmark() {
    final bookmarks = UserSettings.getBookmarks(); //get the bookmarks from the user settings
    if (isBookmarked) { //check if its already bookmarked
      isBookmarked = false; //if yes, unbookmark it
      bookmarks.removeWhere((item) {
        return item.webURL == webURL; //remove the news from the bookmarks using webURL as primary key
      });
    } else {
      isBookmarked = true; //if not, bookmark it
      bookmarks.add(this); //add the news to the bookmarks
    }
    UserSettings.saveBookmarks(bookmarks); //save the bookmarks to the user settings
  }


  //this function converts the news to json format
  //this is used to save the news(i.e, bookmark) to locally.
  //each field if the news object is mapped to a corresponding
  //key-value pair in json
  Map<String, dynamic> toJson() => {
    'title' : title,
    'content' : content,
    'author' : author,
    'timeAgo' : timeAgo,
    'webURL' : webURL,
    'imageURL' : imageURL,
    'authorLogoURL' : authorLogoURL,
    'authorBigLogoURL' : authorBigLogoURL,
    'isBookmarked' : isBookmarked,
  };

  //this is a factory constructor which converts json data into a news object
  //this is used to load the news(i.e, bookmark) from locally.
  //each key-value pair in json is mapped to a corresponding
  //field of the news object
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      timeAgo: json['timeAgo'] as String,
      webURL: json['webURL'] as String,
      imageURL: json['imageURL'] as String?,
      authorLogoURL: json['authorLogoURL'] as String?,
      authorBigLogoURL: json['authorBigLogoURL'] as String?,
      isBookmarked: json['isBookmarked'] as bool,
    );
  }
}