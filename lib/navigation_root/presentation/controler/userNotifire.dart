import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/navigation_root/domain/entities/user.dart';
import 'package:makarr/navigation_root/domain/usecase/featch_current_user_usercase.dart';
import 'package:makarr/navigation_root/presentation/controler/navigation_provider.dart';

class UserNotifireState {
  final User user;
  final bool isLoading;
  final String? error;
  const UserNotifireState({
    required this.user,
    this.isLoading = false,
    this.error,
  });

  UserNotifireState copyWith({User? user, bool? isLoading, String? error}) {
    return UserNotifireState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class UserNotofire extends StateNotifier<UserNotifireState> {
  UserNotofire({required this.featchCurrentUserUsercase})
    : super(UserNotifireState(user: User.empty()));
  final FeatchCurrentUserUsercase featchCurrentUserUsercase;

  Future<void> featchCurrentUser(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await featchCurrentUserUsercase.call(userId);
    result.fold((l) {
      state = state.copyWith(error: l.message, isLoading: false);
    }, (r) => state = state.copyWith(user: r, isLoading: false));
  }
}

final userNotifireProvider =
    StateNotifierProvider<UserNotofire, UserNotifireState>(
      (ref) => UserNotofire(
        featchCurrentUserUsercase: ref.read(featchCurrentUserUsercaseProvider),
      ),
    );
