import 'package:dartz/dartz.dart';
import 'package:makarr/core/entities/opinion.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/notification/data/datasource/basr_notification_datasource.dart';
import 'package:makarr/feature/notification/domain/repository/base_notifications_repo.dart';

class NotificationRapo implements BaseNotificationsRepo {
  NotificationRapo({required this.datasource});
  final BaseNotificationDataSource datasource;
  @override
  Future<Either<Failure, List<String>>> getLocation() async {
    try {
      final List<String> response = await datasource.getLocation();
      return right(response);
    } on FirestoreException catch (e) {
      return Left(ServerFailure(e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPostTitles(String location) async {
    try {
      final result = await datasource.getPostTitles(location);
      return right(result);
    } on FirestoreException catch (e) {
      return Left(ServerFailure(e.errorMessage));

    }
  }
}
