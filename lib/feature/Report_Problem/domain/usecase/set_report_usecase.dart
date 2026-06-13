import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/feature/Report_Problem/domain/entities/report.dart';
import 'package:makarr/feature/Report_Problem/domain/repository/base_report_repo.dart';

class SetReportUsecase implements UseCase<void, Report> {
  SetReportUsecase(this.baseReportRepo);

  final BaseReportRepo baseReportRepo;

  @override
  Future<Either<Failure, dynamic>> call(Report report) async {
    return await baseReportRepo.setReportToDataBase(report);
  }

  Future<Either<Failure, Map<String, dynamic>>> getCurrentLocation() async {
    return await baseReportRepo.getCurrentLocation();
  }
}
