import 'package:equatable/equatable.dart';

class UserNav extends Equatable {
  const UserNav({
    required this.id,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.birthDate,
    required this.email,
    required this.imagUrl,
    required this.wilaya,
    required this.bladya,
    required this.subscription,
    this.type = "Client",
  });
  final String id;
  final String fname;
  final String lname;
  final String phone;
  final String birthDate;
  final String email;
  final String imagUrl;
  final String wilaya;
  final String bladya;
  final String type;
  final String subscription;

  factory UserNav.empty() {
    return const UserNav(
      id: "",
      fname: '',
      lname: '',
      phone: '',
      birthDate: '',
      email: '',
      imagUrl: '',
      wilaya: '',
      bladya: '',
      type: "",
      subscription:""
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
    id,
    type,
    subscription
  ];

  UserNav copyWith({
    String? id,
    String? fname,
    String? lname,
    String? phone,
    String? birthDate,
    String? email,
    String? imagUrl,
    String? wilaya,
    String? bladya,
    String? type,
    String? subscription
  }) {
    return UserNav(
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      imagUrl: imagUrl ?? this.imagUrl,
      wilaya: wilaya ?? this.wilaya,
      bladya: bladya ?? this.bladya,
      type: type ?? this.type,
      subscription: subscription ?? this.subscription
    );
  }
}
