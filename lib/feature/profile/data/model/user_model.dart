import 'package:makarr/feature/profile/domain/entities/user_nav.dart';

class UserModel extends UserNav {
  const UserModel({
    required super.id,
    required super.fname,
    required super.lname,
    required super.phone,
    required super.birthDate,
    required super.email,
    required super.imagUrl,
    required super.wilaya,
    required super.bladya,
    required super.subscription,
    super.type,
  });

  factory UserModel.fromFireBase(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fname: map['Fname'],
      lname: map['Lname'],
      phone: map['Phone'],
      birthDate: map['Birth_Date'],
      email: map['Email'],
      imagUrl: map['ImagUrl'],
      wilaya: map['Wilaya'],
      bladya: map['Bladya'],
      type: map['type'],
      subscription: map["subscription"].toString(),
      //error is here
    );
  }
}
