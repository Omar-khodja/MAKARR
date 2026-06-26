import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/entities/report.dart';
import 'package:makarr/feature/Report_Problem/domain/repository/base_report_repo.dart';

class SetReportUsecase  {
  SetReportUsecase(this.baseReportRepo);

  final BaseReportRepo baseReportRepo;

  Future<Either<Failure, bool>> setReport(Report report) async {
    return await baseReportRepo.setReportToDataBase(report);
  }

  Future<Either<Failure, Map<String, dynamic>>> getCurrentLocation() async {
    return await baseReportRepo.getCurrentLocation();
  }
}
