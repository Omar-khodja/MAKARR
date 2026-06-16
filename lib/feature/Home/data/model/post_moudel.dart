import 'package:makarr/feature/Home/domain/entities/post.dart';

class PostMoudel extends Post {
  const PostMoudel({
    required super.username,
    required super.userImageUrl,
    required super.desciption,
    required super.time,
    required super.id,
    required super.userId,
    required super.pdfName,
    required super.question,
    required super.title,
    super.option,

    super.pdf,
    super.pdfUrl,
    super.photos,
    super.photosUrl,
    super.likeNbr,
    super.opinion,
    super.whoLiked,
    required super.location,
  });
  factory PostMoudel.fromEntity(Post post) {
    return PostMoudel(
      username: post.username,
      title: post.title,
      userImageUrl: post.userImageUrl,
      desciption: post.desciption,
      question: post.question,
      pdf: post.pdf,
      pdfName: post.pdfName,
      time: post.time,
      userId: post.userId,
      id: post.id,
      photos: post.photos,
      photosUrl: post.photosUrl,
      likeNbr: post.likeNbr,
      opinion: post.opinion,
      whoLiked: post.whoLiked,
      location: post.location,
      option: post.option,
    );
  }
  factory PostMoudel.fromMap(Map<String, dynamic> map) {
    return PostMoudel(
      id: map['id'],
      title: map["title"],
      userId: map['userId'],
      username: map['username'],
      userImageUrl: map['userImageUrl'],
      desciption: map['desciption'],
      photosUrl: List<String>.from(map['photosUrl'] ?? []),
      pdfUrl: map['pdfUrl'] ?? '',
      pdfName: map['pdfName'] ?? '',
      time: DateTime.parse(map['time']),
      likeNbr: map['likeNbr'] ?? 0,
      opinion: map['opinion'] ?? 0,
      whoLiked: List<String>.from(map['whoLiked'] ?? []),
      location: map['location'],
      question: map['question'],
      option: List<String>.from(map['option'] ?? []),
    );
  }
  Map<String, dynamic> toClientMap() {
    return {
      'id': id ?? '',
      "title": title,
      'userId': userId,
      'username': username,
      'userImageUrl': userImageUrl,
      'desciption': desciption,
      'photosUrl': photosUrl ?? [],
      'pdfUrl': pdfUrl ?? '',
      'pdfName': pdfName,
      'time': time!.toIso8601String(),
      'likeNbr': likeNbr,
      'opinion': opinion,
      'whoLiked': whoLiked,
      'location': location,
      'question': question,
      'option': option,
    };
  }
    Map<String, dynamic> toInvestorMap() {
    return {
      'id': id ?? '',
      "title": title,
      'userId': userId,
      'username': username,
      'userImageUrl': userImageUrl,
      'desciption': desciption,
      'photosUrl': photosUrl ?? [],
      'pdfUrl': pdfUrl ?? '',
      'pdfName': pdfName,
      'time': time!.toIso8601String(),
      'likeNbr': likeNbr,
      'whoLiked': whoLiked,
      'location': location,
    };
  }
}
