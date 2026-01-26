import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makarr/navigation_root/domain/entities/user_nav.dart';
import 'package:makarr/navigation_root/domain/usecase/featch_current_user_usercase.dart';
import 'package:makarr/navigation_root/presentation/controler/navigation_provider.dart';

class UserNotifireState {
  final UserNav user;
  final bool isLoading;
  final String? error;
  const UserNotifireState({
    required this.user,
    this.isLoading = false,
    this.error,
  });

  UserNotifireState copyWith({UserNav? user, bool? isLoading, String? error}) {
    return UserNotifireState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class UserNotofire extends StateNotifier<UserNotifireState> {
  UserNotofire({required this.featchCurrentUserUsercase})
    : super(UserNotifireState(user: UserNav.empty()));
  final FeatchCurrentUserUsercase featchCurrentUserUsercase;

  Future<void> featchCurrentUser(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await featchCurrentUserUsercase.call(userId);
    result.fold((l) {
      state = state.copyWith(error: l.message, isLoading: false);
    }, (r) => state = state.copyWith(user: r, isLoading: false));
  }

  Future<void> updateProfileImage(String userId, String action) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? xFiles;
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
      state.user,
    );
    result.fold(
      (l) {
        state = state.copyWith(error: l.message);
      },
      (r) {
        state = state.copyWith(user: r);
      },
    );
  }
}

final userNotifireProvider =
    StateNotifierProvider<UserNotofire, UserNotifireState>(
      (ref) => UserNotofire(
        featchCurrentUserUsercase: ref.read(featchCurrentUserUsercaseProvider),
      ),
    );
