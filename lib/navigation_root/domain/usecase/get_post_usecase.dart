import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/navigation_root/domain/entities/post.dart';
import 'package:makarr/navigation_root/domain/repository/base_navigation_repository.dart';

class GetPostUsecase implements UseCase<List<Post>, NoParameters>  {
  GetPostUsecase(this.baseNavigationRepository);

    final BaseNavigationRepository baseNavigationRepository;
  @override
  Future<Either<Failure, List<Post>>> call(NoParameters params) async{
      final posts = await baseNavigationRepository.getPost();
      return posts;
   
  }
  
  Future<void> setLike(String userId, Post post)async {
    final action = post.whoLiked.contains(userId);
    return await baseNavigationRepository.setLike(
      userId,
      post.id!,
      action ? "UnLike" : "Like",
    );
  }
}