import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/profile/domain/entities/user_nav.dart';

abstract class BaseNavigationRepository {
  Future<Either<Failure, UserNav>> getCurrentUserInfo(String userId);
  Future<Either<Failure, UserNav>> updateProfileImage(
    File imageFile,
    String userId,
    UserNav currentUser,
  );
}
