import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ImageNotifier extends StateNotifier<AsyncValue<List<File>>> {
  ImageNotifier() : super(const AsyncValue.data([]));

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    state = const AsyncValue.loading();

    final xFiles = await _imagePicker.pickMultiImage(
      limit: 4,
      imageQuality: 80,
    );

    if (xFiles.isEmpty) {
      // restore previous state if nothing picked
      state = AsyncValue.data(state.value ?? []);
      return;
    }

    final currentImages = state.value ?? [];
    final totalImages = currentImages.length + xFiles.length;

    if (totalImages > 4) {
      Fluttertoast.showToast(msg: "You can only pick 4 images", backgroundColor: Colors.red);
      state = const AsyncValue.data(
        []
      );
      return;
    }

    final newImages = xFiles.map((e) => File(e.path)).toList();
    state = AsyncValue.data([...currentImages, ...newImages]);
  }

  void deleteImage(File image) {
    final currentImages = state.value ?? [];
    final updated = [...currentImages]..remove(image);
    state = AsyncValue.data(updated);
  }
    Future<void> emptyState() async{
    state = const AsyncValue.data([]);
  }
}

final imageNotifierProvider =
    StateNotifierProvider<ImageNotifier, AsyncValue<List<File>>>(
      (ref) => ImageNotifier(),
    );
