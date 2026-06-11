
import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/domain/repository/base_post_repo.dart';

class SetPostUsecase implements UseCase<void, Post> {
  SetPostUsecase(this.basePostRepo);

  final BasePostRepo basePostRepo;

  @override
  Future<Either<Failure, String>> call(Post post) {
    return basePostRepo.setPost(post);
  }

}
