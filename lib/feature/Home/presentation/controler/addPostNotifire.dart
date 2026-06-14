import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/profile/domain/entities/user_nav.dart';
import 'package:makarr/feature/Home/presentation/controler/post_provider.dart';

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

  Future<void> savePost({
    required UserNav user,
    required String des,
    required String title,
    required String location,
    required String question,
    List<String?>? options,
  }) async {
    final userid = user.id;
   
    try {
      final Post post = Post(
        pdfName: state.pdf?.path.split('/').last ?? "",
        userId: userid,
        title: title,
        username: "${user.fname} ${user.lname}",
        userImageUrl: user.imagUrl,
        desciption: des,
        question: question,
        photos: state.imageFile,
        pdf: state.pdf,
        time: DateFormat('y-MM-dd HH:mm').parse(DateTime.now().toString()),
        location: location,
        option: options ?? const [],
      );
      await addPostUsecase.call(post);
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: 'Post Added',
          body: 'Your post has been added successfully!',
          notificationLayout: NotificationLayout.Default,
        ),
      );
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
