import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/domain/usecase/set_post_usecase.dart';
import 'package:makarr/feature/profile/domain/entities/user_nav.dart';
import 'package:makarr/feature/Home/presentation/controler/post_provider.dart';

class AddPostNotifire extends StateNotifier<void> {
  AddPostNotifire({required this.addPostUsecase}) : super(null);
  final SetPostUsecase addPostUsecase;

  Future<void> savePost({
    required UserNav user,
    required String des,
    required String title,
    required String location,
    required File? pdfFile,
    required List<File>? images,
    String? question,
    required String setPostFor,
    List<String?>? options,
  }) async {
    final userid = user.id;

    final Post post = Post(
      pdfName: pdfFile?.path.split('/').last ?? "",
      userId: userid,
      title: title,
      username: "${user.fname} ${user.lname}",
      userImageUrl: user.imagUrl,
      desciption: des,
      question: question,
      photos: images,
      pdf: pdfFile,
      time: DateFormat('y-MM-dd HH:mm').parse(DateTime.now().toString()),
      location: location,
      option: options ?? const [],
    );
    final result = await addPostUsecase.setPost(post, setPostFor);

    result.fold(
      (l) => Fluttertoast.showToast(
        msg: "Failes to publish",
        backgroundColor: Colors.red,
      ),
      (r) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'Post Added',
            body: 'Your post has been added successfully!',
            notificationLayout: NotificationLayout.Default,
          ),
        );
      },
    );
  }
}

final addPostNotifireProvider =
    StateNotifierProvider.autoDispose<AddPostNotifire, void>(
      (ref) =>
          AddPostNotifire(addPostUsecase: ref.read(setPostUsecaseProvider)),
    );
