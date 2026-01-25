import 'dart:io';

import 'package:equatable/equatable.dart';

class Post extends Equatable {
 const Post({
    this.id,
    required this.username,
    required this.userImageUrl,
    required this.desciption,
    required this.pdf,
    required this.time,
    this.photos,
    this.photosUrl,
    this.likeNbr,
    this.commentNbr,
  });
  final String? id ;
  final String username;
  final String userImageUrl;
  final String desciption;
  final List<File>? photos;
  final List<String>? photosUrl;
  final File? pdf;
  final DateTime? time;
  final int? likeNbr;
  final int? commentNbr;
  @override
  List<Object?> get props => [
    id,
    username,
    userImageUrl,
    desciption,
    photos,
    photosUrl,
    pdf,
    time,
    likeNbr,
    commentNbr
  ];
  factory Post.empty() {
    return Post(
      username: '',
      userImageUrl: '',
      desciption: '',
      pdf: null,
      time:  DateTime.now(),
    );
  }
}