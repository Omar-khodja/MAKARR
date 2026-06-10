import 'dart:io';

import 'package:makarr/feature/profile/data/model/user_model.dart';

abstract class BaseDataSource {
  Future<UserModel> getUserById(String userId);
  Future<String> updateProfileImage(File imageFile, String userId);
}
