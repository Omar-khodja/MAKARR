import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/navigation_root/domain/entities/user.dart';
import 'package:makarr/navigation_root/domain/repository/base_navigation_repository.dart';

class FeatchCurrentUserUsercase extends UseCase<User, String> {
  FeatchCurrentUserUsercase({required this.baseNavigationRepository});

  final BaseNavigationRepository baseNavigationRepository;
  @override
  Future<Either<Failure, User>> call(String userId) async {
    return await baseNavigationRepository.getCurrentUserInfo(userId);
  }

  Future<Either<Failure, User>> updateProfileImage(
    File imageFile,
    String userId,
    User currentUser,
  ) async {
    return await baseNavigationRepository.updateProfileImage(
      imageFile,
      userId,
      currentUser,
    );
  }
}
