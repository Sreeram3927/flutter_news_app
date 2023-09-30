import 'package:flutter/material.dart';


//this widget is used to display the title and the children
class TitleAndChild extends StatelessWidget {
  final String title;
  final double? width;
  final Function()? onSeeAll;
  final bool border;
  final List<Widget> children;
  const TitleAndChild({
    super.key,
    required this.title,
    required this.children,
    this.width,
    this.border = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    //use sliverToBoxAdapter if parent widget requires a sliver
    return SliverToBoxAdapter(
      child: Container(
        //add margin to the container if border is true
        margin: border ? const EdgeInsets.all(10) : null,
        //add decoration to the container if border is true
        decoration: border ? BoxDecoration(
          border: Border.all(color: Colors.grey[500]!),
          borderRadius: BorderRadius.circular(10),
        ) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding( //add padding to the widget
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width,
                    //show the title of the widget
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //show the see all button if onSeeAll functoin is not null
                  if (onSeeAll != null) TextButton(
                    onPressed: onSeeAll, //call the onSeeAll function when the user taps on the button
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(), //add a divider to divide children from the title
            //show all the children
            //... is used to add all the children to this list
            ...children,
          ],
        ),
      ),
    );
  }
}