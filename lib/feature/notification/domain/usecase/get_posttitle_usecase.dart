import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/notification/domain/repository/base_notifications_repo.dart';

class GetPosttitleUsecase {
  GetPosttitleUsecase({required this.repo});
  final BaseNotificationsRepo repo;
  Future<Either<Failure, List<String>>> getPostTitile(String location) async {
    return await repo.getPostTitles(location);
  }
}
