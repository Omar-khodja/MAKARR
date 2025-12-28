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


}
