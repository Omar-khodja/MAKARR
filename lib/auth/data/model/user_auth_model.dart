import 'package:makarr/auth/domain/entities/user_auth.dart';

class UserAuthModel extends UserAuth {
  const UserAuthModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.email,
    required super.birthDate,
    required super.password,
  });
  factory UserAuthModel.fromEntity(UserAuth user) {
    return UserAuthModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      phone: user.phone,
      email: user.email,
      birthDate: user.birthDate,
      password: user.password,
    );
  }
}
