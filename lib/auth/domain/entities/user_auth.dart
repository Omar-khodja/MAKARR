import 'package:equatable/equatable.dart';

class UserAuth extends Equatable {
  const UserAuth({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.password,
    required this.wilaya,
    required this.bladya,
  });
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String birthDate;
  final String password;
  final String wilaya;
  final String bladya;

    @override
    List<Object?> get props => [
      firstName,
      lastName,
      phone,
      email,
      birthDate,
      password,
      wilaya,
      bladya
    ];
}
