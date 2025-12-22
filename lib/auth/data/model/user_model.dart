import 'package:makarr/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.email,
    required super.birthDate,
    required super.imagUrl,
  });
  factory UserModel.fromfirebase(Map<String, dynamic> data) {
    return UserModel(
      id: data['UserId'],
      firstName: data['Fname'],
      lastName: data['Lname'],
      phone: data['Phone'],
      email: data['Email'],
      birthDate: data['Birth_Date'],
      imagUrl: data['ImagUrl'],
    );
  }
}
