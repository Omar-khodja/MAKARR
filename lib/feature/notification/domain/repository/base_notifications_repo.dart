import 'package:dartz/dartz.dart';
import 'package:makarr/core/entities/opinion.dart';
import 'package:makarr/core/error/failure.dart';

abstract class BaseNotificationsRepo {
    Future<Either<Failure, Opinion>> getOpinion();
  Future<Either<Failure, List<String>>> getLocation();
}