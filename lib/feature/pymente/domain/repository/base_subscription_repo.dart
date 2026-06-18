import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';

abstract class BaseSubscriptionRepo {
  Future<Either<Failure , String>> subscription(String plan,String userId);
    Future<Either<Failure, String>> checkSubscription( String userId);

}