import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/profile/data/datasource/base_profile_datasource.dart';
import 'package:makarr/feature/profile/domain/entities/user_nav.dart';
import 'package:makarr/feature/profile/domain/repository/base_profile_repository.dart';

class NavigationRepository extends BaseNavigationRepository {
  NavigationRepository({required this.baseDataSource});
  final BaseDataSource baseDataSource;

  @override
  Future<Either<Failure, UserNav>> getCurrentUserInfo(String userId) async {
    try {
      final user = await baseDataSource.getUserById(userId);
      return Right(user);
    } on FirestoreException catch (e) {
      AppLogger.e(e.errorMessage);
      return  Left(ServerFailure(e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserNav>> updateProfileImage(
    File imageFile,
    String userId,
    UserNav currentUser,
  ) async {
    try {
      final imageurl = await baseDataSource.updateProfileImage(
        imageFile,
        userId,
      );
      final UserNav user = currentUser.copyWith(imagUrl: imageurl);
      return Right(user);
    } on StorageException catch (e) {
      AppLogger.e(e.errorMessage);
      return Left(ServerFailure(e.errorMessage));
    } on FirestoreException catch (e) {
      AppLogger.e(e.errorMessage);
      return Left(ServerFailure(e.errorMessage));
    } catch (e) {
      AppLogger.e(e.toString());
      return const Left(ServerFailure("Failed to update profile image"));
    }
  }
}
