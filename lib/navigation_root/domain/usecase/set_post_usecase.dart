
import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/navigation_root/domain/entities/post.dart';
import 'package:makarr/navigation_root/domain/repository/base_navigation_repository.dart';

class SetPostUsecase implements UseCase<void, Post> {
  SetPostUsecase(this.baseNavigationRepository);

  final BaseNavigationRepository baseNavigationRepository;

  @override
  Future<Either<Failure, String>> call(Post post) {
    return baseNavigationRepository.setPost(post);
  }

}
