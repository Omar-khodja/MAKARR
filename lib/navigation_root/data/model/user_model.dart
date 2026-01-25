import 'package:makarr/navigation_root/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.fname,
    required super.lname,
    required super.phone,
    required super.birthDate,
    required super.email,
    required super.imagUrl,
    required super.wilaya,
    required super.bladya,
  });
  factory UserModel.fromFireBase(Map<String,dynamic> map){
    return UserModel(
      fname: map['Fname']??'',
      lname: map['Lname']??'',
      phone: map['Phone']??'',
      birthDate: map['Birth_Date']??'',
      email: map['Email']??'',
      imagUrl: map['ImagUrl']??'',
      wilaya: map['Wilaya']??'',
      bladya: map['Bladya']??'',
    );
  }
  UserModel copyWith({
    String? fname,
    String? lname,
    String? phone,
    String? birthDate,
    String? email,
    String? imagUrl,
    String? wilaya,
    String? bladya,
  }) {
    return UserModel(
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

