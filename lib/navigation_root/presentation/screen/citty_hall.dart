import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getPostNotifireProvider.notifier).getPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getPostNotifireProvider);
    return Skeletonizer(
      enabled: state.isLoading,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.post.length,
        itemBuilder: (context, index) {
          final post = state.post[index];
          return PostCard(carouselController: carouselController, post: post);
        },
      ),
    );
  }
}
