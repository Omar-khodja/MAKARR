import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ImageNotifire extends StateNotifier<AsyncValue<List<File>>> {
  ImageNotifire() : super(const AsyncValue.data([]));

  Future<void> pickImages() async {
    final xFiles = await ImagePicker().pickMultiImage(
      limit: 4,
      imageQuality: 80,
    );
    final currentState = state.value ?? [];
    if (xFiles.isEmpty) return;
    final totalImages = currentState.length + xFiles.length;
    if (totalImages > 4) {
      Fluttertoast.showToast(
        msg: "You can only pick 4 images",
      );
      return;
    }
    state = const AsyncValue.loading();
    final List<File> newImages = xFiles.map((item) => File(item.path)).toList();
    state = AsyncValue.data([...currentState, ...newImages]);
  }

  Future<void> removeImage(File image) async {
    final images = state.value ?? [];
    images.remove(image);
    state = AsyncValue.data([...images]);
  }
}
final imageNotifireProvider = StateNotifierProvider((ref) => ImageNotifire(),);