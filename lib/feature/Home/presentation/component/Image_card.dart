import 'dart:io';

import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.image, required this.onDelete});
  final File image;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          right: 2,
          top: 2,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 20),
              onPressed: onDelete,
            ),
          ),
        ),
      ],
    );
  }
}
