import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/Report_Problem/domain/entities/report.dart';

abstract class BaseReportRepo {
  Future<Either<Failure, void>> setReportToDataBase(Report report);
  Future<Either<Failure, Map<String, dynamic>>> getCurrentLocation();
}
