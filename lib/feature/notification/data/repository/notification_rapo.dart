import 'package:dartz/dartz.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/entities/opinion.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/Report_Problem/domain/entities/report.dart';
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
      AppLogger.e("getLocation: ${e.errorMessage}");

      return Left(ServerFailure(e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPostTitles(String location) async {
    try {
      final result = await datasource.getPostTitles(location);
      return right(result);
    } on FirestoreException catch (e) {
      AppLogger.e("getPostTitles: ${e.errorMessage}");
      return Left(ServerFailure(e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Opinion>>> getOptions(
    String postTitle,
    String location,
  ) async {
    try {
      final result = await datasource.getOptions(postTitle, location);
      return right(result);
    } on FirestoreException catch (e) {
      AppLogger.e("getOptions: ${e.errorMessage}");

      return Left(ServerFailure(e.errorMessage));
    }
  }
  
  @override
  Future<Either<Failure, List<String>>> getReportLocation()async {
   try {
      final List<String> response = await datasource.getReportLocation();
      return right(response);
    } on FirestoreException catch (e) {
      AppLogger.e("getReportLocation: ${e.errorMessage}");
      return Left(ServerFailure(e.errorMessage));
    }
  }
  
  @override
  Future<Either<Failure, List<Report>>>  getReport(String location)async {
    try {
      final List<Report> response = await datasource.getReport(location);
      return right(response);
    } on FirestoreException catch (e) {
      AppLogger.e("get Report: ${e.errorMessage}");
      return Left(ServerFailure(e.errorMessage));
    }
  }
}
