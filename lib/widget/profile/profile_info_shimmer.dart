import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileInfoShimmer extends StatelessWidget {
  const ProfileInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.primaryContainer,
          highlightColor: Theme.of(context).colorScheme.onPrimaryContainer,
          child: Container(
            width: double.infinity,
            height: 80,
            margin: const EdgeInsetsDirectional.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
       
        ...List.generate(
          4,
          (index) => Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surfaceContainer,
            highlightColor: Theme.of(context).colorScheme.onSecondaryContainer,
            child: Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsetsDirectional.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.primary,
          highlightColor: Theme.of(context).colorScheme.onPrimary,
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
