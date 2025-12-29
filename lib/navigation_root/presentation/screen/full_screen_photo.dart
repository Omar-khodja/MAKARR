import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenPhoto extends StatefulWidget {
  const FullScreenPhoto({
    super.key,
    required this.images,
    required this.initialIndex,
  });
  final List<String> images;
  final int initialIndex;

  @override
  State<FullScreenPhoto> createState() => _FullScreenPhotoState();
}

class _FullScreenPhotoState extends State<FullScreenPhoto> {
  late final PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialIndex);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PhotoViewGallery.builder(
        pageController: pageController,
        itemCount: widget.images.length,
        builder: (context, index) => PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(widget.images[index]),
          maxScale: PhotoViewComputedScale.covered * 2,
          minScale: PhotoViewComputedScale.contained,
        ),
      ),
    );
  }
}
