import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/feature/post/domain/entities/post.dart';
import 'package:makarr/feature/post/domain/repository/base_post_repo.dart';

class GetPostUsecase implements UseCase<List<Post>, NoParameters>  {
  GetPostUsecase(this.basePostRepo);

    final BasePostRepo basePostRepo;
  @override
  Future<Either<Failure, List<Post>>> call(NoParameters params) async{
      final posts = await basePostRepo.getPost();
      return posts;
   
  }
  
  Future<void> setLike(String userId, Post post)async {
    final action = post.whoLiked.contains(userId);
    return await basePostRepo.setLike(
      userId,
      post.id!,
      action ? "UnLike" : "Like",
    );
  }
}