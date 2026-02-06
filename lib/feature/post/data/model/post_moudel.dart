import 'package:makarr/feature/post/domain/entities/post.dart';

class PostMoudel extends Post {
  const PostMoudel({
    required super.username,
    required super.userImageUrl,
    required super.desciption,
    required super.time,
    required super.id,
    required super.userId,
    required super.pdfName,
    super.pdf,
    super.pdfUrl,
    super.photos,
    super.photosUrl,
    super.likeNbr,
    super.commentNbr,
    super.whoLiked,
  });
  factory PostMoudel.fromEntity(Post post) {
    return PostMoudel(
      username: post.username,
      userImageUrl: post.userImageUrl,
      desciption: post.desciption,
      pdf: post.pdf,
      pdfName: post.pdfName,
      time: post.time,
      userId: post.userId,
      id: post.id,
      photos: post.photos,
      photosUrl: post.photosUrl,
      likeNbr: post.likeNbr,
      commentNbr: post.commentNbr,
      whoLiked: post.whoLiked,
    );
  }
  factory PostMoudel.fromMap(Map<String, dynamic> map) {
    return PostMoudel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      userImageUrl: map['userImageUrl'] ?? '',
      desciption: map['desciption'] ?? '',
      photosUrl: List<String>.from(map['photosUrl'] ?? []),
      pdfUrl: map['pdfUrl'] ?? '',
      pdfName: map['pdfName'] ?? '',
      time: DateTime.parse(map['time']),
      likeNbr: map['likeNbr'] ?? 0,
      commentNbr: map['commentNbr'] ?? 0,
      whoLiked: List<String>.from(map['whoLiked'] ?? []),
    );

  }
  Map<String, dynamic> toMap() {
    return {
      'id': id ?? '',
      'userId': userId,
      'username': username,
      'userImageUrl': userImageUrl,
      'desciption': desciption,
      'photosUrl': photosUrl ?? [],
      'pdfUrl':  pdfUrl ?? '',
      'pdfName': pdfName,
      'time': time!.toIso8601String() ,
      'likeNbr': likeNbr,
      'commentNbr': commentNbr,
      'whoLiked': whoLiked,
    };
  }
}
