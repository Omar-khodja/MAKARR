import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/navigation_root/domain/entities/post.dart';
import 'package:makarr/navigation_root/presentation/component/post/post_card.dart';
import 'package:makarr/navigation_root/presentation/controler/get_postNotifire.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CittyHall extends ConsumerStatefulWidget {
  const CittyHall({super.key});

  @override
  ConsumerState<CittyHall> createState() => _CittyHallState();
}

class _CittyHallState extends ConsumerState<CittyHall> {
  CarouselController carouselController = CarouselController();
  @override
  void dispose() {
    super.dispose();
    carouselController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getPostNotifireProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(getPostNotifireProvider.notifier).getPost();
      },
      child: state.when(
        data: (data) => Skeletonizer(
          enabled: false,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final post = data[index];
              return PostCard(
                carouselController: carouselController,
                post: post,
              );
            },
          ),
        ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Skeletonizer(
          enabled: true,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return PostCard(
                carouselController: carouselController,
                post: Post(
                  userId: "",
                  username: "username",
                  userImageUrl:
                      "https://firebasestorage.googleapis.com/v0/b/makarr-bc736.firebasestorage.app/o/profile_images%2FgW6AJ2U71dVXZOh7LdogxC3Tbfp2.jpg?alt=media&token=e761f634-a337-4285-ba18-c10c5cfb5e89",
                  desciption:
                      "If you want, I can rewrite your full CittyHall + PostCarousel + CachedNetworkImage + PhotoView using AsyncValue, pull-to-refresh, sorted posts, and stable image caching, fully production-ready.",
                  time: DateTime.now(),
                  pdfName: "",
                  photosUrl:const  ["https://firebasestorage.googleapis.com/v0/b/makarr-bc736.firebasestorage.app/o/profile_images%2FgW6AJ2U71dVXZOh7LdogxC3Tbfp2.jpg?alt=media&token=e761f634-a337-4285-ba18-c10c5cfb5e89"]
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
