import 'package:dartz/dartz.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/pymente/data/datasource/base_subscription%20_datasource.dart';
import 'package:makarr/feature/pymente/domain/repository/base_subscription_repo.dart';

class SubscriptionRepo implements BaseSubscriptionRepo {
  SubscriptionRepo({required this.dataSource});
  final BasesubscriptionDatasource dataSource;
  @override
  Future<Either<Failure, String>> subscription(String plan, String userId)async {
    try{
      final reslut = await dataSource.subscription(plan, userId);
      return Right(reslut);

    }catch(e){
      AppLogger.e(e.toString(), className: "pymentrepo");
      return Left(ServerFailure(e.toString()));

    }
  }

  @override
  Future<Either<Failure, String>> checkSubscription(String userId)async {
    try{
      final subscription = await dataSource.checksubscription( userId);
      return Right(subscription);

    }catch(e){
      AppLogger.e(e.toString(),className: "pymentrepo");
      return Left(ServerFailure(e.toString()));

    }
  }
}