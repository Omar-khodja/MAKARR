import 'package:makarr/auth/data/model/user_model.dart';

abstract class BaseDataSourse {
  Future<void> createUser(String email, String password, UserModel user);
  Future<UserModel> getUserById(String id);
  Future<void> login(String email, String password);
  
  
}