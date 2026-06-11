import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makarr/feature/profile/domain/entities/user_nav.dart';
import 'package:makarr/feature/profile/domain/usecase/featch_current_user_usercase.dart';
import 'package:makarr/feature/profile/presentation/controler/navigation_provider.dart';





class UserNotofire extends StateNotifier<AsyncValue<UserNav>> {
  UserNotofire({required this.featchCurrentUserUsercase})
    : super(const AsyncValue.loading());
  final FeatchCurrentUserUsercase featchCurrentUserUsercase;

  Future<void> featchCurrentUser(String userId) async {
    state = const AsyncValue.loading();
    final result = await featchCurrentUserUsercase.call(userId);
    result.fold((l) {
      state =  AsyncValue.error(l, StackTrace.current);
    }, (r) => state = AsyncValue.data(r));
  }

  Future<void> updateProfileImage(String userId, String action) async {
    final currentUser = state.value;
    if (currentUser == null) return; 
    final ImagePicker imagePicker = ImagePicker();
     XFile? xFiles;
    if (action == 'camera') {
      xFiles = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
    } else {
      xFiles = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
    }
    if (xFiles == null) return;
    final newImage = File(xFiles.path);

    final result = await featchCurrentUserUsercase.updateProfileImage(
      newImage,
      userId,
      state.value!,
    );
    result.fold(
      (l) {
        state =  AsyncValue.error('Failed to update profile image', StackTrace.current);
      },
      (r) {
        state = AsyncValue.data(r);
      },
    );
  }
}

final userNotifireProvider =
    StateNotifierProvider<UserNotofire, AsyncValue<UserNav>>(
      (ref) => UserNotofire(
        featchCurrentUserUsercase: ref.read(featchCurrentUserUsercaseProvider),
      ),
    );
