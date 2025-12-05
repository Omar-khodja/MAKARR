import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/appLogger.dart';
import 'package:makarr/provider/user_Provider.dart';
import 'package:makarr/widget/Custom_elevatedButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makarr/widget/Image_card.dart';
import 'package:makarr/widget/user_card_info.dart';
import 'package:video_player/video_player.dart';

class ReportProblem extends ConsumerStatefulWidget {
  const ReportProblem({super.key});

  @override
  ConsumerState<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends ConsumerState<ReportProblem> {
  final ImagePicker _imagePicker = ImagePicker();
  final List<File?> _imageFile = [];
  VideoPlayerController? _videoController;
  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            UserCardInfo(name: "${user.firstName} ${user.lastName}"),
            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Describe the issue...",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            if (_imageFile.isNotEmpty)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _imageFile.map((file) {
                  return SizedBox(
                    width:
                        (MediaQuery.of(context).size.width - 60) /
                        2, // two items per row
                    height: 180,
                    child: ImageCard(
                      image: file!,
                      onDelete: () => deleteImage(file),
                    ),
                  );
                }).toList(),
              ),
            if (_videoController != null)
              GestureDetector(
                onDoubleTap: () {
                  _videoController!.value.isPlaying
                      ? _videoController!.pause()
                      : _videoController!.play();
                },
                child: AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                ),
              ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: .spaceEvenly,

              children: [
                if (_videoController == null)
                  CustomElevatedbutton(
                    label: 'Photo',
                    leadIcon: Icons.photo_library_outlined,
                    fun: pickImage,
                  ),
                if (_imageFile.isEmpty)
                  CustomElevatedbutton(
                    label: 'Video',
                    leadIcon: Icons.video_library_outlined,
                    fun: pickVideo,
                  ),
              ],
            ),
          ],
        ),
      ),
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
      showAlert("You can only select up to 4 images.");
      return;
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

  Future<void> pickVideo() async {
    final xFile = await _imagePicker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );
    if (xFile != null) {
      await initializeVideoPlayer(File(xFile.path));
    }
  }

  Future<void> initializeVideoPlayer(File file) async {
    _videoController?.dispose();
    _videoController = VideoPlayerController.file(file);

    await _videoController!.initialize();
    _videoController!.setLooping(true);
    _videoController!.play();

    setState(() {});
  }
}
