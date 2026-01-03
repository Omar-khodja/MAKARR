import 'package:flutter/material.dart';
import 'package:makarr/navigation_root/presentation/screen/full_screen_photo.dart';

class PostCarousel extends StatefulWidget {
  const PostCarousel({
    super.key,
    required this.controller,
    required this.images,
  });
  final CarouselController controller;
  final List<String> images;

  @override
  State<PostCarousel> createState() => _PostCarouselState();
}

class _PostCarouselState extends State<PostCarousel> {
  late final List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = widget.images
        .map((p) => Image.asset(p, fit: BoxFit.fill))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return CarouselView(
      controller: widget.controller,
      itemExtent: width * .8,
      shrinkExtent: height * .2,
      children: _children,
      onTap: (index) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FullScreenPhoto(images: widget.images, initialIndex: index),
        ),
      ),
    );
  }
}
