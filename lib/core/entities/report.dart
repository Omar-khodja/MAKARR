import 'dart:io';

import 'package:equatable/equatable.dart';

class Report extends Equatable {
  const Report({
    this.id,
    required this.titel,
    required this.discreption,
    required this.date,
    required this.lat,
    required this.lng,
    required this.address,
    required this.userId,
    required this.userName,
    required this.userprofile,
    this.imagesUrl,
    this.images ,
  });
  final String? id;
  final String userId;
  final String userName;
  final String userprofile;
  final String titel;
  final String discreption;
  final List<File>? images;
  final List<String>? imagesUrl;
  final String lng;
  final String lat;
  final String address;
  final DateTime date;

  @override
  List<Object?> get props => [
    id,
    titel,
    discreption,
    images,
    date,
    lat,
    lng,
    address,
    userId,
    userName,
    userprofile,
  ];
}
