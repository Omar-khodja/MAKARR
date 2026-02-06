import 'package:makarr/feature/auth/domain/entities/user_auth.dart';

class UserAuthModel extends UserAuth {
  const UserAuthModel({
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.email,
    required super.birthDate,
    required super.password,
    required super.wilaya,
    required super.bladya,
  });
  factory UserAuthModel.fromEntity(UserAuth user) {
    return UserAuthModel(
      firstName: user.firstName,
      lastName: user.lastName,
      phone: user.phone,
      email: user.email,
      birthDate: user.birthDate,
      password: user.password,
      wilaya: user.wilaya,
      bladya: user.bladya,
    );
  }
}
