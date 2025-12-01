import 'dart:io';

import 'package:flutter/material.dart';
import 'package:makarr/appLogger.dart';
import 'package:makarr/widget/Custom_elevatedButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makarr/widget/Image_card.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  final ImagePicker _imagePicker = ImagePicker();
  final List<File?> _imageFile = [];
  File? _VideoFile;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: height * 0.5,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _imageFile.isNotEmpty
              ? GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    mainAxisExtent: 200,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  children: _imageFile
                      .map(
                        (e) => ImageCard(
                          image: e!,
                          onDelete: () => deleteImage(e),
                        ),
                      )
                      .toList(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Icon(
                        Icons.photo_library_outlined,
                        size: 50,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "Add Photo / Video",
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: .spaceEvenly,

          children: [
            CustomElevatedbutton(
              label: 'Photo',
              leadIcon: Icons.photo_library_outlined,
              fun: pickImage,
            ),
            CustomElevatedbutton(
              label: 'Video',
              leadIcon: Icons.video_library_outlined,
              fun: () {},
            ),
          ],
        ),
      ],
    );
  }

  void showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_outlined),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    final xFiles = await _imagePicker.pickMultiImage(
      limit: 4,
      imageQuality: 80,
    );
    AppLogger.i(
      "number of selected images: ${xFiles.length} / ${_imageFile.length}",
    );
    if (_imageFile.length > 4 || _imageFile.length + xFiles.length > 4) {
      showAlert("You have already selected the maximum number of images (4).");
      return;
    }
    if (xFiles.length > 4) {
      final limitedImages = xFiles.take(4).toList();
      showAlert("You can only select up to 4 images.");

      setState(() {
        _imageFile.addAll(limitedImages.map((e) => File(e.path)));
      });
    } else if (xFiles.isNotEmpty) {
      setState(() {
        _imageFile.addAll(xFiles.map((e) => File(e.path)));
      });
    }
  }

  void deleteImage(File image) {
    setState(() {
      _imageFile.remove(image);
    });
  }
}
/* Column(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              Center(
                child: Icon(
                  Icons.video_library_outlined,
                  size: 50,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                "Add Photo / Video",
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ), */