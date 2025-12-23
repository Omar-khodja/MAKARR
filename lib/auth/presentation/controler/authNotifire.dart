import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/auth/domain/entities/user_auth.dart';
import 'package:makarr/auth/domain/usecase/createuser_usecase.dart';
import 'package:makarr/auth/domain/usecase/login_usecase.dart';
import 'package:makarr/auth/domain/usecase/singout_usecase.dart';
import 'package:makarr/auth/presentation/controler/auth_provider.dart';
import 'package:makarr/auth/presentation/controler/authstate.dart';

class Authnotifire extends StateNotifier<AuthState> {
  Authnotifire({
    required this.createuserUsecase,
    required this.loginUsecase,
    required this.singoutUsecase,
  }) : super(const AuthState());
  final CreateuserUsecase createuserUsecase;
  final SingoutUsecase singoutUsecase;
  final LoginUsecase loginUsecase;

  Future<void> createUser(UserAuth user) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await createuserUsecase.call(user);
    result.fold((l) {
      state = state.copyWith(isLoading: false, error: l.message);
      AppLogger.e(l.message);
    }, (r) => state = state.copyWith(isLoading: false));
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await loginUsecase.call(email, password);
    result.fold((l) {
      state = state.copyWith(isLoading: false, error: l.message);
      AppLogger.e(l.message);
    }, (r) => state = state.copyWith(isLoading: false));
  }

  Future<void> singOut() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await singoutUsecase.call();
    result.fold((l) {
      state = state.copyWith(isLoading: false, error: l.message);
      AppLogger.e(l.message);
    }, (r) => state = state.copyWith(isLoading: false));
  }
}

final authNotifireProvider = StateNotifierProvider<Authnotifire, AuthState>(
  (ref) => Authnotifire(
    createuserUsecase: ref.read(createUserUseCaseProvider),
    loginUsecase: ref.read(loginUseCaseProvider),
    singoutUsecase: ref.read(singOutUseCaseProvider),
  ),
);
