import 'package:flutter/material.dart';
import 'package:makarr/navigation_root/presentation/component/post/post_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CarouselController carouselController = CarouselController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    carouselController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .center,
        children: [
          PostCard(carouselController: carouselController),
          PostCard(carouselController: carouselController),
        ],
      ),
    );
  }
}
