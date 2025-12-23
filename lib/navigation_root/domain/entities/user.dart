import 'package:equatable/equatable.dart';

class User extends Equatable {
 const User({
    required this.userId,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.birthDate,
    required this.email,
    required this.imagUrl,
  });

 final String userId;
 final String fname;
 final String lname;
 final String phone;
 final String birthDate;
 final String email;
 final String imagUrl;
  
  @override
  List<Object?> get props => [
    userId,
    fname,
    lname,
    phone,
    birthDate,
    email,
    imagUrl,
  ];


}
