import 'dart:io';

import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    this.id,
    required this.userId,
    required this.title,
    required this.username,
    required this.userImageUrl,
    required this.desciption,
    required this.time,
    required this.location,
     this.question,
    this.pdfName,
    this.pdf,
    this.pdfUrl,
    this.photos,
    this.photosUrl,
    this.likeNbr = 0,
    this.opinion = 0,
    this.whoLiked = const [],
    this.option = const [],
  });
  final String? id;
  final String title;
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
  final int? opinion;
  final List<String> whoLiked;
  final String location;
  final String? question;
  final List<String?>? option;
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
    opinion,
    whoLiked,
    pdfUrl,
    pdfName,
    time
  ];
  factory Post.empty() {
    return Post(
      id: null,
      title: "",
      userId: '',
      username: '',
      userImageUrl: '',
      desciption: '',
      pdf: null,
      time: DateTime.now(),
      likeNbr: 0,
      opinion: 0,
      whoLiked: const [],
      pdfName: '',
      photos: const [],
      photosUrl: const [],
      pdfUrl: '',
      location: '',
      question: '',
      option: const [],
    );
  }

  Post copyWith({
    String? id,
    String? title,
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
    int? opinion,
    List<String>? whoLiked,
    String? location,
  }) {
    return Post(
      id: id ?? this.id,
      title:  title ?? this.title,
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
      opinion: opinion ?? this.opinion,
      whoLiked: whoLiked ?? this.whoLiked,
      location: location ?? this.location,
      question: question,
      option: option,
    );
  }
}
