import 'package:flutter/material.dart';

class TitleAndChild extends StatelessWidget {
  final String title;
  final Function()? onSeeAll;
  final bool border;
  final List<Widget> children;
  const TitleAndChild({
    super.key,
    required this.title,
    required this.children,
    this.border = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: border ? const EdgeInsets.all(10) : null,
        decoration: border ? BoxDecoration(
          border: Border.all(color: Colors.grey[500]!),
          borderRadius: BorderRadius.circular(10),
        ) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (onSeeAll != null) TextButton(
                    onPressed: onSeeAll,
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
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }
}