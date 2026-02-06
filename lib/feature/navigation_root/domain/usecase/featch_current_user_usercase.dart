import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/feature/navigation_root/domain/entities/user_nav.dart';
import 'package:makarr/feature/navigation_root/domain/repository/base_navigation_repository.dart';

class FeatchCurrentUserUsercase extends UseCase<UserNav, String> {
  FeatchCurrentUserUsercase({required this.baseNavigationRepository});

  final BaseNavigationRepository baseNavigationRepository;
  @override
  Future<Either<Failure, UserNav>> call(String userId) async {
    return await baseNavigationRepository.getCurrentUserInfo(userId);
  }

  Future<Either<Failure, UserNav>> updateProfileImage(
    File imageFile,
    String userId,
    UserNav currentUser,
  ) async {
    return await baseNavigationRepository.updateProfileImage(
      imageFile,
      userId,
      currentUser,
    );
  }
}
