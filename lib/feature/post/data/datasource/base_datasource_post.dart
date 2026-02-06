
import 'package:makarr/feature/post/data/model/post_moudel.dart';

abstract class BaseDatasourcePost {
    Future<void> setPost(PostMoudel post);
  Future<List<PostMoudel>> getPost();
  Future<void> setLike(String userId, String postId, String action);

}