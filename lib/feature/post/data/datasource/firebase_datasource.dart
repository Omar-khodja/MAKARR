import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/feature/post/data/datasource/base_datasource_post.dart';
import 'package:makarr/feature/post/data/model/post_moudel.dart';

class FirebaseDatasource implements BaseDatasourcePost {
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  final FirebaseStorage storageRef = FirebaseStorage.instance;
   @override
  Future<void> setPost(PostMoudel post) async {
    final List<String> photosUrl = [];
    String pdfUrl;

    try {
      final postref = await firestoreRef.collection("Posts").add(post.toMap());
      for (int i = 0; i < post.photos!.length; i++) {
        final imageRef = storageRef.ref().child(
          'post_images/${postref.id}/image_$i.jpg',
        );
        await imageRef.putFile(post.photos![i]);
        final imageUrl = await imageRef.getDownloadURL();
        photosUrl.add(imageUrl);
      }
      final fileRef = storageRef.ref().child('post_pdfs/${postref.id}.pdf');
      await fileRef.putFile(post.pdf!);
      pdfUrl = await fileRef.getDownloadURL();
      AppLogger.i(photosUrl.toString());
      AppLogger.i(pdfUrl);
      await postref.update({
        "id": postref.id,
        'photosUrl': photosUrl,
        'pdfUrl': pdfUrl,
      });
    } on FirebaseException catch (e) {
      throw ServerException(errorMessage: e.message ?? 'Firebase error');
    } catch (e) {
      throw ServerException(errorMessage: 'Unexpected error: $e');
    }
  }

  @override
  Future<List<PostMoudel>> getPost() async {
    try {
      final snapshot = await firestoreRef
          .collection("Posts")
          .orderBy("time", descending: true)
          .get();
      final List<PostMoudel> posts = snapshot.docs
          .map((item) => PostMoudel.fromMap(item.data()))
          .toList();
      return posts;
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: 'Unexpected error: $e');
    }
  }

  @override
  Future<void> setLike(String userId, String postId, String action) async {
    try {
      if (action == "Like") {
        await firestoreRef.collection("Posts").doc(postId).update({
          "likeNbr": FieldValue.increment(1),
          "whoLiked": FieldValue.arrayUnion([userId]),
        });
      } else {
        await firestoreRef.collection("Posts").doc(postId).update({
          "likeNbr": FieldValue.increment(-1),
          "whoLiked": FieldValue.arrayRemove([userId]),
        });
      }
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: e.message!);
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  } 
}