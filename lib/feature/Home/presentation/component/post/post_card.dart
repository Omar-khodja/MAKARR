import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/presentation/component/post/postCarousel.dart';
import 'package:makarr/feature/Home/presentation/component/post/post_iconbutton.dart';
import 'package:makarr/feature/Home/presentation/component/post/post_user_info.dart';
import 'package:makarr/feature/Home/presentation/controler/Investment_provider.dart';
import 'package:makarr/feature/Home/presentation/controler/get_post_provider.dart';
import 'package:makarr/feature/Home/presentation/screen/give_opinion.dart';
import 'package:makarr/feature/Home/presentation/screen/pdfViewer.dart';

class PostCard extends ConsumerWidget {
  const PostCard({
    super.key,
    required this.carouselController,
    required this.post,
    required this.userId,
    required this.postType,
  });
  final CarouselController carouselController;
  final Post post;
  final String userId;
  final String postType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darcktheme = Theme.of(context).brightness == Brightness.dark;
    final state = ref.read(getPostNotifireProvider.notifier);
    final stateinvestment = ref.read(investmentNotifireProvider.notifier);

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
              textAlign: .start,
              style: TextStyle(
                fontSize: 16,
                color: darcktheme ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          if (post.photosUrl?.isNotEmpty == true)
            SizedBox(
              height: 300,
              child: PostCarousel(
                controller: carouselController,
                images: post.photosUrl!,
              ),
            ),
          const SizedBox(height: 10),
          if (post.pdfUrl?.isNotEmpty == true) const Divider(),
          if (post.pdfUrl?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pdfviewer(pdfUrl: post.pdfUrl),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Theme.of(context).colorScheme.secondaryContainer,
                leading: Image.asset("assets/image/pdf.png", width: 40),
                title: Text(post.pdfName!),
                subtitle: const Text("2.5 MB"),
              ),
            ),
          const SizedBox(height: 10),
          const Divider(),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: .start,

              children: [
                PostIconbutton(
                  icon: post.whoLiked.contains(userId)
                      ? FontAwesome5Solid.heart
                      : FontAwesome5Regular.heart,
                  counter: post.likeNbr,
                  active: post.whoLiked.contains(userId),
                  onPressed: () => postType == "Client"
                      ? state.setLike(userId, post)
                      : stateinvestment.setLike(userId, post),
                ),
                if (postType == "Client")
                PostIconbutton(
                  icon: FontAwesome5Regular.comment,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GiveOpinion(post: post),
                    ),
                  ),
                ),
             

                const Spacer(),
                PostIconbutton(
                  icon: FontAwesome5Regular.bookmark,
                  active: false,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
