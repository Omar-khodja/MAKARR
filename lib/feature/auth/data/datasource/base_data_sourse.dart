import 'package:makarr/feature/auth/data/model/user_auth_model.dart';

abstract class BaseDataSourse {
  Future<void> createUser(UserAuthModel user);
  Future<void> login(String email, String password);
  Future<void> singOut();
}
