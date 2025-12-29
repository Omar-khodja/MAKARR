import 'package:flutter/material.dart';
import 'package:makarr/navigation_root/presentation/component/post/post_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CittyHall extends StatefulWidget {
  const CittyHall({super.key});

  @override
  State<CittyHall> createState() => _CittyHallState();
}

class _CittyHallState extends State<CittyHall> {
  CarouselController carouselController = CarouselController();
  @override
  void dispose() {
    super.dispose();
    carouselController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Skeletonizer(
        enabled: false,
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: [
            PostCard(carouselController: carouselController),
            PostCard(carouselController: carouselController),
            PostCard(carouselController: carouselController),
          ],
        ),
      ),
    );
  }
}
