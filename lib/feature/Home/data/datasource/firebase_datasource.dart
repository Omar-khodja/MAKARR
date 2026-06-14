import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/feature/Home/data/datasource/base_datasource_post.dart';
import 'package:makarr/core/models/opinion_model.dart';
import 'package:makarr/feature/Home/data/model/post_moudel.dart';

class FirebaseDatasource implements BaseDatasourcePost {
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  @override
  Future<void> setPost(PostMoudel post) async {
    final List<String> photosUrl = [];
    String pdfUrl = "";

    try {
      final postref = await firestoreRef
          .collection("Locations")
          .doc(post.location)
          .collection("Posts")
          .add(post.toMap());
      if (post.photos?.isNotEmpty == true) {
        for (int i = 0; i < post.photos!.length; i++) {
          final imageRef = storageRef.ref().child(
            'post_images/${postref.id}/image_$i.jpg',
          );
          await imageRef.putFile(post.photos![i]);
          final imageUrl = await imageRef.getDownloadURL();
          photosUrl.add(imageUrl);
        }
      }
      if (post.pdf != null) {
        final fileRef = storageRef.ref().child('post_pdfs/${postref.id}.pdf');
        await fileRef.putFile(post.pdf!);
        pdfUrl = await fileRef.getDownloadURL();
      }
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
  Future<List<PostMoudel>> getPost(String location) async {
    try {
      final snapshot = await firestoreRef
          .collection("Locations")
          .doc(location)
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
  Future<void> setLike(
    String userId,
    String postId,
    String action,
    String location,
  ) async {
    try {
      if (action == "Like") {
        await firestoreRef
            .collection("Locations")
            .doc(location)
            .collection("Posts")
            .doc(postId)
            .update({
              "likeNbr": FieldValue.increment(1),
              "whoLiked": FieldValue.arrayUnion([userId]),
            });
      } else {
        await firestoreRef
            .collection("Locations")
            .doc(location)
            .collection("Posts")
            .doc(postId)
            .update({
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

  @override
  Future<void> setOpinion(OpinionModel opinio) async {
    try {
      await firestoreRef.collection("Opinions").doc(opinio.postLocation).set({
        "title": opinio.postLocation,
      });
      await firestoreRef
          .collection("Opinions")
          .doc(opinio.postLocation)
          .collection(opinio.postTitle)
          .add(opinio.toJson());
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: e.message!);
    }
  }
}
