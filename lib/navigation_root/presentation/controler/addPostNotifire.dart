import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makarr/core/applogger/appLogger.dart';
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
    bool? isLoading,
    String? error,
    List<File>? imageFile,
    File? pdf,
  }) {
    return AddpostnotifireState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      imageFile: imageFile ?? this.imageFile,
      pdf: pdf ?? this.pdf,
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
    if (totalImages > 4) {
      state = state.copyWith(error: "You can only pick 4 images");
      return;
    }
    final List<File> newImages = xFiles.map((item) => File(item.path)).toList();
    state = state.copyWith(
      imageFile: [...state.imageFile, ...newImages],
      error: null,
    );
  }

  Future<void> removeImage(File image) async {
    final images = state.imageFile;
    images.remove(image);
    state = state.copyWith(imageFile: images);
  }

  Future<void> pickPdfFile() async {
    try {
      state = state.copyWith(error: null, isLoading: true);
      final xFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );
      if (xFile == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final file = File(xFile.files.first.path!);
      state = state.copyWith(pdf: file, isLoading: false);
      AppLogger.i(state.pdf!.path);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "An error occurred while picking the PDF file.",
      );
    }
  }

  Future<void> removePdf() async {
    AppLogger.i("Removing PDF file");
    state = state.copyWith(pdf: File(""));
  }
}

final addPostNotifireProvider =
    StateNotifierProvider<AddPostNotifire, AddpostnotifireState>(
      (ref) =>
          AddPostNotifire(addPostUsecase: ref.read(setPostUsecaseProvider)),
    );
