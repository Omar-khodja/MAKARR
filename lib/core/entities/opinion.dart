import 'package:equatable/equatable.dart';

class Opinion extends Equatable {
  const Opinion({
    this.id = '',
    required this.postId,
    required this.opinion,
    this.comment,
    required this.postLocation,
    required this.userId,
    required this.question,
    required this.userProfile,
    required this.postTitle
  });
  final String id;
  final String postTitle;
  final String postId;
  final String opinion;
  final String? comment;
  final String postLocation;
  final String userId;
  final String question;
  final String userProfile;

  @override
  List<Object?> get props => [
    postId,
    opinion,
    comment,
    postLocation,
    userId,
    userProfile,
    id,
    question,
    postTitle
  ];
}
