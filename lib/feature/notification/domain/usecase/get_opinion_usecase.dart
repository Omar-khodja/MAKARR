import 'package:dartz/dartz.dart';
import 'package:makarr/core/entities/opinion.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/notification/domain/repository/base_notifications_repo.dart';

class GetOpinionUsecase {
  GetOpinionUsecase({required this.repo});
  final BaseNotificationsRepo repo;
  Future<Either<Failure, List<Opinion>>> getOpinion(
    String postTitle,
    String location,
  ) async {
    return await repo.getOptions(postTitle, location);
  }
}
