import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/navigation_root/presentation/controler/navigation_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenPhoto extends ConsumerStatefulWidget {
  const FullScreenPhoto({
    super.key,
    required this.images,
    required this.initialIndex,
  });
  final List<String> images;
  final int initialIndex;

  @override
  ConsumerState<FullScreenPhoto> createState() => _FullScreenPhotoState();
}

class _FullScreenPhotoState extends ConsumerState<FullScreenPhoto> {
  late final PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
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
          imageProvider: CachedNetworkImageProvider(
            widget.images[index],
            cacheManager: ref.read(photoViewCacheManagerProvider),
          ),
          maxScale: PhotoViewComputedScale.covered * 2,
          minScale: PhotoViewComputedScale.contained,
        ),
      ),
    );
  }
}
