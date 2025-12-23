import 'package:makarr/navigation_root/data/model/user_model.dart';

abstract class BaseDataSource {
  Future<UserModel> getUserById(String userId);
}