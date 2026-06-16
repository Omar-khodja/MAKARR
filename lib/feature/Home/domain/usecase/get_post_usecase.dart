import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/domain/repository/base_post_repo.dart';

class GetPostUsecase {
  GetPostUsecase(this.basePostRepo);

  final BasePostRepo basePostRepo;
  Future<Either<Failure, List<Post>>> getClientPost(String location) async {
    final posts = await basePostRepo.getPost(location);
    return posts;
  }
    Future<Either<Failure, List<Post>>> getInvestmentPost() async {
    final posts = await basePostRepo.getInvestmentPost();
    return posts;
  }

  Future<void> setLike(String userId, Post post,String type) async {
    final action = post.whoLiked.contains(userId);
    return await basePostRepo.setLike(
      userId,
      post.id!,
      action ? "UnLike" : "Like",
      post.location,
      type
    );
  }
}
