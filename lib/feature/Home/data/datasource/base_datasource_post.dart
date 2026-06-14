import 'package:makarr/core/models/opinion_model.dart';
import 'package:makarr/feature/Home/data/model/post_moudel.dart';

abstract class BaseDatasourcePost {
  Future<void> setPost(PostMoudel post);
  Future<List<PostMoudel>> getPost(String location);
  Future<void> setLike(
    String userId,
    String postId,
    String action,
    String location,
  );
  Future<void> setOpinion(OpinionModel opinio);
}
