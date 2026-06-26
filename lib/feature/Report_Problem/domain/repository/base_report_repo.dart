import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/entities/report.dart';

abstract class BaseReportRepo {
  Future<Either<Failure, bool>> setReportToDataBase(Report report);
  Future<Either<Failure, Map<String, dynamic>>> getCurrentLocation();
}
