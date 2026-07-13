import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/domain/repository/base_post_repo.dart';

class SetPostUsecase  {
  SetPostUsecase(this.basePostRepo);

  final BasePostRepo basePostRepo;

  Future<Either<Failure, String>> setPost(Post post, String postForWho) {
    if(postForWho == "Client"){

    return basePostRepo.setPost(post);
    }else{
      return basePostRepo.setInvestorPost(post);
    }
  }
}
