import 'dart:io';

import 'package:equatable/equatable.dart';

class Post extends Equatable {
 const Post({
    this.id,
    required this.userId,
    required this.username,
    required this.userImageUrl,
    required this.desciption,
    required this.time,
    this.pdfName ,
    this.pdf,
    this.pdfUrl,
    this.photos,
    this.photosUrl,
    this.likeNbr =0,
    this.commentNbr = 0,
    this.whoLiked = const [],
  });
  final String? id ;
  final String userId;
  final String username;
  final String userImageUrl;
  final String desciption;
  final String? pdfName;
  final List<File>? photos;
  final List<String>? photosUrl;
  final File? pdf;
  final String? pdfUrl;
  final DateTime? time;
  final int? likeNbr;
  final int? commentNbr;
  final List<String> whoLiked ;
  @override
  List<Object?> get props => [
    id,
    userId,
    username,
    userImageUrl,
    desciption,
    photos,
    photosUrl,
    pdf,
    time,
    likeNbr,
    commentNbr
    ,whoLiked,
    pdfUrl,
    pdfName,
  ];
  factory Post.empty() {
    return Post(
      id: null,
      userId: '',
      username: '',
      userImageUrl: '',
      desciption: '',
      pdf: null,
      time:  DateTime.now(),
      likeNbr: 0,
      commentNbr: 0,
      whoLiked: const [],
      pdfName: '',
      photos: const [],
      photosUrl: const [],
      pdfUrl: '',
    );
  }

  Post copyWith({
    String? id,
    String? userId,
    String? username,
    String? userImageUrl,
    String? desciption,
    String? pdfName,
    List<File>? photos,
    List<String>? photosUrl,
    File? pdf,
    String? pdfUrl,
    DateTime? time,
    int? likeNbr,
    int? commentNbr,
    List<String>? whoLiked,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userImageUrl: userImageUrl ?? this.userImageUrl,
      desciption: desciption ?? this.desciption,
      pdfName: pdfName ?? this.pdfName,
      photos: photos ?? this.photos,
      photosUrl: photosUrl ?? this.photosUrl,
      pdf: pdf ?? this.pdf,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      time: time ?? this.time,
      likeNbr: likeNbr ?? this.likeNbr,
      commentNbr: commentNbr ?? this.commentNbr,
      whoLiked: whoLiked ?? this.whoLiked,
    );
  }
}