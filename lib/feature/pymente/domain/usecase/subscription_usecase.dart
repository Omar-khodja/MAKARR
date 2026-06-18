import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/pymente/domain/repository/base_subscription_repo.dart';

class SubscriptionUsecase {
  SubscriptionUsecase({required this.repo});
  final BaseSubscriptionRepo repo;
  Future<Either<Failure, String>> subscription(
    String plan,
    String userId,
  ) async {
    return await repo.subscription(plan, userId);
  }

  Future<Either<Failure, bool>> checkSubscription(String userId) async {
    final subscription = await repo.checkSubscription(userId);

    return subscription.fold((l) => Left(l), (dateString) {
      final date = DateTime.parse(dateString.replaceFirst(" ", "T"));
      final isExpired = DateTime.now().isAfter(date);
      return Right(isExpired);
    });
  }
}
