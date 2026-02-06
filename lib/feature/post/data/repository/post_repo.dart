import 'package:dartz/dartz.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/post/data/datasource/base_datasource_post.dart';
import 'package:makarr/feature/post/data/model/post_moudel.dart';
import 'package:makarr/feature/post/domain/entities/post.dart';
import 'package:makarr/feature/post/domain/repository/base_post_repo.dart';

class PostRepo implements BasePostRepo {
  PostRepo({required this.baseDataSourcepost});
  final BaseDatasourcePost baseDataSourcepost;

  @override
  Future<Either<Failure, String>> setPost(Post post) async {
    try {
      await baseDataSourcepost.setPost(PostMoudel.fromEntity(post));
      return const Right("sep post seccessfully");
    } catch (e) {
      AppLogger.e(e.toString());
      return  Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPost() async {
    try {
      final posts = await baseDataSourcepost.getPost();
      return Right(posts);
    } catch (e) {
      AppLogger.e(e.toString());
      return const Left(ServerFailure("Failed to get posts"));
    }
  }

  @override
  Future<void> setLike(String userId, String postId, String action) async {
    try {
      await baseDataSourcepost.setLike(userId, postId, action);
    } catch (e) {
      AppLogger.e(e.toString());
    }
  }
}