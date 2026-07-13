import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/core/entities/opinion.dart';
import 'package:makarr/feature/Home/domain/repository/base_post_repo.dart';

class OpinionUsecase extends UseCase<void, Opinion> {
  OpinionUsecase(this.basePostRepo);

  final BasePostRepo basePostRepo;

  @override
  Future<Either<Failure, void>> setOpinion(Opinion opinio) {
    return basePostRepo.setOpinion(opinio);
  }
}
