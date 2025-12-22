import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.password,
  });
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String birthDate;
  final String password;

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    phone,
    email,
    birthDate,
    password,
  ];
}
