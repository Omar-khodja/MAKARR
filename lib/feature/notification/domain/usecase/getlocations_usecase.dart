import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/notification/domain/repository/base_notifications_repo.dart';

class GetlocationsUsecase   {
  GetlocationsUsecase({required this.repo});
  final BaseNotificationsRepo repo;
  Future<Either<Failure, List<String>>> getlocation() async{
    return await repo.getLocation();
    
  }
}