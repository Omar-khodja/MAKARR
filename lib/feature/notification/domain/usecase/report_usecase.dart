import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/Report_Problem/domain/entities/report.dart';
import 'package:makarr/feature/notification/domain/repository/base_notifications_repo.dart';

class ReportUsecase {
  ReportUsecase({required this.repo});
  final BaseNotificationsRepo repo;
  Future<Either<Failure, List<Report>>> getReport(String location) async {
    return await repo.getReport(location);
  }

}
