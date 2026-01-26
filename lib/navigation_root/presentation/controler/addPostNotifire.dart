import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/navigation_root/domain/entities/post.dart';
import 'package:makarr/navigation_root/domain/entities/user_nav.dart';
import 'package:makarr/navigation_root/presentation/controler/navigation_provider.dart';

class AddpostnotifireState {
  AddpostnotifireState({
    this.imageFile = const [],
    this.isLoading = false,
    this.error,
    this.pdf,
  });
  final bool isLoading;
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

  factory AddpostnotifireState.empty() {
    return AddpostnotifireState(
      isLoading: false,
      imageFile: [],
      error: null,
      pdf: null,
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

  Future<void> savePost(UserNav user, String des) async {
    final userid = FirebaseAuth.instance.currentUser?.uid;
    if (des.isEmpty) {
      state = state.copyWith(error: "You must add a description");
      return;
    } else if (state.imageFile.isEmpty &&
        (state.pdf == null || state.pdf!.path.isEmpty)) {
      state = state.copyWith(error: "You must add  an image and a pdf file");
      return;
    }

    try {
      final Post post = Post(
        pdfName: state.pdf!.path.split('/').last,
        userId: userid!,
        username: "${user.fname} ${user.lname}",
        userImageUrl: user.imagUrl,
        desciption: des,
        photos: state.imageFile,
        pdf: state.pdf,
        time: DateFormat('y-MM-dd HH:mm').parse(DateTime.now().toString()),
      );
      await addPostUsecase.call(post);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final addPostNotifireProvider =
    StateNotifierProvider.autoDispose<AddPostNotifire, AddpostnotifireState>(
      (ref) =>
          AddPostNotifire(addPostUsecase: ref.read(setPostUsecaseProvider)),
    );
