import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/navigation_root/presentation/controler/navigation_provider.dart';
import 'package:makarr/navigation_root/presentation/screen/full_screen_photo.dart';

class PostCarousel extends ConsumerStatefulWidget {
  const PostCarousel({
    super.key,
    required this.controller,
    required this.images,
  });
  final CarouselController controller;
  final List<String> images;

  @override
  ConsumerState<PostCarousel> createState() => _PostCarouselState();
}

class _PostCarouselState extends ConsumerState<PostCarousel> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if (widget.images.isEmpty) return const SizedBox();
    return CarouselView(
      controller: widget.controller,
      itemExtent: width * .9,
      shrinkExtent: height * .1,
      children: widget.images
          .map(
            (image) => CachedNetworkImage(
              cacheManager: ref.watch(photoViewCacheManagerProvider),
              imageUrl: image,
              fit: BoxFit.cover,
              cacheKey: image.split('?').first,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )
          .toList(),
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
