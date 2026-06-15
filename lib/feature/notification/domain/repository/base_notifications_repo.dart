import 'package:dartz/dartz.dart';
import 'package:makarr/core/entities/opinion.dart';
import 'package:makarr/core/error/failure.dart';

abstract class BaseNotificationsRepo {
  Future<Either<Failure, List<String>>> getPostTitles(String location);
  Future<Either<Failure, List<String>>> getLocation();
     Future<Either<Failure, List<Opinion>>> getOptions(String postTitle, String location);

}
