import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:makarr/navigation_root/presentation/component/post/postCarousel.dart';
import 'package:makarr/navigation_root/presentation/component/post/post_iconbutton.dart';
import 'package:makarr/navigation_root/presentation/component/post/post_user_info.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.carouselController});
  final CarouselController carouselController;
  static const List<String> images = [
    "assets/image/imag1.jpg",
    "assets/image/imag2.jpg",
    "assets/image/imag3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
   
    final darcktheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        children: [
          const PostUserInfo(),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
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
            child: PostCarousel(controller: carouselController, images: images)
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Theme.of(context).colorScheme.secondaryContainer,
              leading: Image.asset("assets/image/pdf.png", width: 40),
              title: const Text("Project_Space2.pdf"),
              subtitle: const Text("2.5 MB"),
              trailing: const Icon(Icons.download_outlined),
            ),
          ),
          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: .start,

              children: [
                PostIconbutton(
                  icon: FontAwesome5Regular.thumbs_up,
                  counter: 120,
                ),
                PostIconbutton(icon: FontAwesome5Regular.comment, counter: 24),
                Spacer(),
                PostIconbutton(icon: FontAwesome5Regular.bookmark),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

