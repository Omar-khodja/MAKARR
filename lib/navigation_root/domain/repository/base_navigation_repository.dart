

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/navigation_root/domain/entities/report.dart';
import 'package:makarr/navigation_root/domain/entities/user.dart';

abstract class BaseNavigationRepository {

Future<Either<Failure , User>> getCurrentUserInfo(String userId);
Future<Either<Failure, void>> setReportToDataBase(Report report);
Future<Either<Failure, Map<String , dynamic>>> getCurrentLocation();
Future<Either<Failure, User>> updateProfileImage(File imageFile, String userId,User currentUser);



}