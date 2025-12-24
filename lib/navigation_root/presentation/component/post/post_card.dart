import 'package:flutter/material.dart';
import 'package:makarr/navigation_root/presentation/component/post/post_user_info.dart';

class PostCard extends StatelessWidget {
  PostCard({super.key, required this.carouselController});
  final CarouselController carouselController;
  final children = [
    Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final darcktheme = Theme.of(context).brightness == Brightness.dark;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        children: [
          const PostUserInfo(),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Text(
              "lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: TextStyle(
                fontSize: 18,
                color: darcktheme ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 250,
            child: CarouselView(
              controller: carouselController,
              elevation: 5,
              itemExtent: width * .8,
              shrinkExtent: height * .2,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
