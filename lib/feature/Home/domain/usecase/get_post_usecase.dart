import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/domain/repository/base_post_repo.dart';

class GetPostUsecase implements UseCase<List<Post>, String>  {
  GetPostUsecase(this.basePostRepo);

    final BasePostRepo basePostRepo;
  @override
  Future<Either<Failure, List<Post>>> call(String location) async{
      final posts = await basePostRepo.getPost(location);
      return posts;
   
  }
  
  Future<void> setLike(String userId, Post post)async {
    final action = post.whoLiked.contains(userId);
    return await basePostRepo.setLike(
      userId,
      post.id!,
      action ? "UnLike" : "Like",
      post.location,
    );
  }
}