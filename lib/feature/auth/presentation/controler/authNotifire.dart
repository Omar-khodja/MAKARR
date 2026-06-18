import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/feature/auth/domain/entities/user_auth.dart';
import 'package:makarr/feature/auth/domain/usecase/createuser_usecase.dart';
import 'package:makarr/feature/auth/domain/usecase/login_usecase.dart';
import 'package:makarr/feature/auth/domain/usecase/singout_usecase.dart';
import 'package:makarr/feature/auth/presentation/controler/auth_provider.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthNotifier extends StateNotifier<AsyncValue<UserAuth?>> {
  AuthNotifier({
    required this.createuserUsecase,
    required this.loginUsecase,
    required this.singoutUsecase,
  }) : super(const AsyncValue.data(null));

  final CreateuserUsecase createuserUsecase;
  final LoginUsecase loginUsecase;
  final SingoutUsecase singoutUsecase;

  Future<void> createUser(UserAuth user) async {
    final result = await createuserUsecase.call(user);
    result.fold(
      (l) =>
          Fluttertoast.showToast(msg: l.message, backgroundColor: Colors.red),
      (r) => Fluttertoast.showToast(msg: "User created successfully"),
    );
  }

  Future<void> login(String email, String password) async {
    final result = await loginUsecase.call((email, password));
    result.fold(
      (l) =>
          Fluttertoast.showToast(msg: l.message, backgroundColor: Colors.red),
      (r) => Fluttertoast.showToast(msg: "Login successfully"),
    );
  }

  Future<void> signOut() async {
    final result = await singoutUsecase.call(const NoParameters());
    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => Fluttertoast.showToast(msg: "Sign out successfully"),
    );
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserAuth?>>((ref) {
      return AuthNotifier(
        createuserUsecase: ref.read(createUserUseCaseProvider),
        loginUsecase: ref.read(loginUseCaseProvider),
        singoutUsecase: ref.read(singOutUseCaseProvider),
      );
    });
