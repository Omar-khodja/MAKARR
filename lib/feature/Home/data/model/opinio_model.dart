import 'package:makarr/feature/Home/domain/entities/opinion.dart';

class OpinioModel extends Opinion {
  OpinioModel({
    required super.postId,
    required super.opinion,
    super.comment,
    required super.postLocation,
    required super.userId,
    required super.userProfile,
    required super.id,
    required super.question,
  });
  factory OpinioModel.fromJson(Map<String, dynamic> json) {
    return OpinioModel(
      id: json['id'],
      postId: json['postId'],
      opinion: json['opinion'],
      comment: json['comment'],
      postLocation: json['postLocation'],
      userId: json['userId'],
      userProfile: json['userProfile'],
      question: json["question"],
    );
  }
  factory OpinioModel.fromEntity(Opinion opinio) {
    return OpinioModel(
      id: opinio.id,
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
      'opinion': opinion,
      'comment': comment,
      'postLocation': postLocation,
      'userId': userId,
      'userProfile': userProfile,
      "question": question,
    };
  }
}
