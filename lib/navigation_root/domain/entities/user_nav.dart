import 'package:equatable/equatable.dart';

class UserNav extends Equatable {
  const UserNav({
    required this.fname,
    required this.lname,
    required this.phone,
    required this.birthDate,
    required this.email,
    required this.imagUrl,
    required this.wilaya,
    required this.bladya,
  });

  final String fname;
  final String lname;
  final String phone;
  final String birthDate;
  final String email;
  final String imagUrl;
  final String wilaya;
  final String bladya;

  factory UserNav.empty() {
    return const UserNav(
      fname: '',
      lname: '',
      phone: '',
      birthDate: '',
      email: '',
      imagUrl: '',
      wilaya: '',
      bladya: '',
    );
  }

  @override
  List<Object?> get props => [
    fname,
    lname,
    phone,
    birthDate,
    email,
    imagUrl,
    wilaya,
    bladya,
  ];

  UserNav copyWith({
    String? fname,
    String? lname,
    String? phone,
    String? birthDate,
    String? email,
    String? imagUrl,
    String? wilaya,
    String? bladya,
  }) {
    return UserNav(
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      imagUrl: imagUrl ?? this.imagUrl,
      wilaya: wilaya ?? this.wilaya,
      bladya: bladya ?? this.bladya,
    );
  }
}
