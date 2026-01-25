import 'package:equatable/equatable.dart';

class User extends Equatable {
 const User({
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
 
 factory User.empty() {
    return const User(
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
    bladya
  ];

User copyWith({
    String? fname,
    String? lname,
    String? phone,
    String? birthDate,
    String? email,
    String? imagUrl,
    String? wilaya,
    String? bladya,
  }) {
    return User(
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
