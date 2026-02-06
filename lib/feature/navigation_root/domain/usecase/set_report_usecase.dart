import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/feature/navigation_root/domain/entities/report.dart';
import 'package:makarr/feature/navigation_root/domain/repository/base_navigation_repository.dart';

class SetReportUsecase implements UseCase<void, Report> {
  SetReportUsecase(this.baseNavigationRepository);

  final BaseNavigationRepository baseNavigationRepository;

  @override
  Future<Either<Failure, dynamic>> call(Report report) async {
    return await baseNavigationRepository.setReportToDataBase(report);
  }
  Future<Either<Failure , Map<String , dynamic>>> getCurrentLocation()async {
   return await baseNavigationRepository.getCurrentLocation();
  }
}
