import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/navigation_root/domain/entities/post.dart';
import 'package:makarr/navigation_root/presentation/controler/navigation_provider.dart';

class AddpostnotifireState {
  AddpostnotifireState({
    this.imageFile = const [],
    this.post = const Post(
      username: '',
      userImageUrl: '',
      desciption: '',
      pdf: null,
      time: null,
    ),
    this.isLoading = false,
    this.error,
    this.pdf,
  });
  final bool isLoading;
  final Post post;
  final String? error;
  final File? pdf;
  final List<File> imageFile;
  AddpostnotifireState copyWith({
    Map<String, dynamic>? position,
    bool? isLoading,
    String? error,
    List<File>? imageFile,
    String? video,
    bool? isGettingLocation,
  }) {
    return AddpostnotifireState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}

class AddPostNotifire extends StateNotifier<AddpostnotifireState> {
  AddPostNotifire({required this.addPostUsecase})
    : super(AddpostnotifireState());
  final UseCase addPostUsecase;

  Future<void> pickImages() async {
    final xFiles = await ImagePicker().pickMultiImage(
      limit: 4,
      imageQuality: 80,
    );
    if (xFiles.isEmpty) return;
    final totalImages = state.imageFile.length + xFiles.length;
    if (totalImages > 6) {
      state = state.copyWith(error: "You can only pick 6 images");
      return;
    }
    final List<File> newImages = xFiles.map((item)=> File(item.path)).toList();
    state = state.copyWith(imageFile: [...state.imageFile, ...newImages],error: null);
  }
}

final addPostNotifireProvider =
    StateNotifierProvider<AddPostNotifire, AddpostnotifireState>(
      (ref) =>
          AddPostNotifire(addPostUsecase: ref.read(setPostUsecaseProvider)),
    );
