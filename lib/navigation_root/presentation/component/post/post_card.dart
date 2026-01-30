import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:makarr/navigation_root/domain/entities/post.dart';
import 'package:makarr/navigation_root/presentation/component/post/postCarousel.dart';
import 'package:makarr/navigation_root/presentation/component/post/post_iconbutton.dart';
import 'package:makarr/navigation_root/presentation/component/post/post_user_info.dart';
import 'package:makarr/navigation_root/presentation/screen/pdfViewer.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.carouselController,
    required this.post,
  });
  final CarouselController carouselController;
  final Post post;

  @override
  Widget build(BuildContext context) {
    final darcktheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 4, top: 4),
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        children: [
           PostUserInfo(
            imageUrl: post.userImageUrl,
            time: post.time!,
            username: post.username,
          ),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: Text(
              post.desciption,
              style: TextStyle(
                fontSize: 18,
                color: darcktheme ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 300,
            child: PostCarousel(
              controller: carouselController,
              images: post.photosUrl!,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),

          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pdfviewer(
                      pdfUrl: post.pdfUrl,
                    ),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Theme.of(context).colorScheme.secondaryContainer,
              leading: Image.asset("assets/image/pdf.png", width: 40),
              title:  Text(post.pdfName),
              subtitle: const Text("2.5 MB"),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
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
        ],
      ),
    );
  }
}
