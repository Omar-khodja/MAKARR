import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/post/domain/entities/post.dart';

abstract class BasePostRepo {
    Future<Either<Failure, String>> setPost(Post post);
  Future<Either<Failure, List<Post>>> getPost();
  Future<void> setLike(String userId, String postId, String action);
}