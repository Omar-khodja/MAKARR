import 'package:makarr/auth/data/model/user_model.dart';

abstract class BaseDataSourse {
  Future<void> createUser(UserModel user);
  Future<void> login(String email, String password);
  Future<void> singOut();
}
