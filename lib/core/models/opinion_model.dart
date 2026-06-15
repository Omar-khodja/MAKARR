import 'package:makarr/core/entities/opinion.dart';

class OpinionModel extends Opinion {
 const OpinionModel({
    required super.postId,
    required super.opinion,
    super.comment,
    required super.postLocation,
    required super.userId,
    required super.userProfile,
    required super.id,
    required super.question,
    required super.postTitle
  });
  factory OpinionModel.fromJson(Map<String, dynamic> json) {
    return OpinionModel(
      id: json['id'],
      postTitle: json["postTitle"],
      postId: json['postId'],
      opinion: json['opinion'],
      comment: json['comment'],
      postLocation: json['postLocation'],
      userId: json['userId'],
      userProfile: json['userProfile'],
      question: json["question"],
    );
  }
  factory OpinionModel.fromEntity(Opinion opinio) {
    return OpinionModel(
      id: opinio.id,
      postTitle: opinio.postTitle,
      postId: opinio.postId,
      opinion: opinio.opinion,
      comment: opinio.comment,
      postLocation: opinio.postLocation,
      userId: opinio.userId,
      userProfile: opinio.userProfile,
      question: opinio.question,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'postTitle': postTitle,
      'opinion': opinion,
      'comment': comment,
      'postLocation': postLocation,
      'userId': userId,
      'userProfile': userProfile,
      "question": question,
    };
  }
}
