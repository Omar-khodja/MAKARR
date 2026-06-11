
import 'package:makarr/feature/Home/data/model/post_moudel.dart';

abstract class BaseDatasourcePost {
    Future<void> setPost(PostMoudel post);
  Future<List<PostMoudel>> getPost(String location);
  Future<void> setLike(String userId, String postId, String action);

}