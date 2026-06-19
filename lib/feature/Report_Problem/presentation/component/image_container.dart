import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/Home/presentation/component/Image_card.dart';
import 'package:makarr/feature/Report_Problem/presentation/controler/image_provider.dart';

class ImageContainer extends ConsumerWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final images = ref.watch(imageNotifierProvider);
    final imageProvider = ref.read(imageNotifierProvider.notifier);

    return images.when(data: (data) =>   Wrap(
              spacing: 5,
              runSpacing: 5,
              children: images.value!.map((file) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 60) / 2,
                  height: 180,
                  child: ImageCard(
                    image: file,
                    onDelete: () => imageProvider.deleteImage(file),
                  ),
                );
              }).toList(),
            ), error: (error, stackTrace) => const SizedBox(), loading: () =>const  Center(child: CircularProgressIndicator(),),);
  }
}