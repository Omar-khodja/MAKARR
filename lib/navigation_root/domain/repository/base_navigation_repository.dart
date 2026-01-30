import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/navigation_root/domain/entities/post.dart';
import 'package:makarr/navigation_root/domain/entities/report.dart';
import 'package:makarr/navigation_root/domain/entities/user_nav.dart';

abstract class BaseNavigationRepository {
  Future<Either<Failure, UserNav>> getCurrentUserInfo(String userId);
  Future<Either<Failure, void>> setReportToDataBase(Report report);
  Future<Either<Failure, Map<String, dynamic>>> getCurrentLocation();
  Future<Either<Failure, UserNav>> updateProfileImage(
    File imageFile,
    String userId,
    UserNav currentUser,
  );
  Future<Either<Failure, String>> setPost(Post post);
    Future<Either<Failure, List<Post>>> getPost();

}
