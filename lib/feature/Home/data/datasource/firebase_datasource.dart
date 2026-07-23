import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:makarr/core/applogger/appLogger.dart';
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
          .collection("ClientPost")
          .doc(post.location)
          .collection("Posts")
          .add(post.toClientMap());
      if (post.photos?.isNotEmpty == true) {
        for (int i = 0; i < post.photos!.length; i++) {
          final imageRef =  storageRef.ref().child(
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
      AppLogger.e(e.message ?? "setpost error");
      throw FirestoreException(
        errorMessage: e.message ?? 'somthing went wrong try again later',
      );
    }
  }

  @override
  Future<List<PostMoudel>> getPost(String location) async {
    try {
      final snapshot = await firestoreRef
          .collection("ClientPost")
          .doc(location)
          .collection("Posts")
          .orderBy("time", descending: true)
          .get();
      final List<PostMoudel> posts = snapshot.docs
          .map((item) => PostMoudel.fromMapClient(item.data()))
          .toList();
      return posts;
    } on FirebaseException catch (e) {
      AppLogger.e(e.message ?? "get post error");

      throw FirestoreException(
        errorMessage: e.message ?? "somthing went wrong try again later",
      );
    }
  }

  @override
  Future<void> setLike(
    String userId,
    String postId,
    String action,
    String location,
    String type,
  ) async {
    try {
      if (action == "Like") {
        if (type == "Client") {
          await firestoreRef
              .collection("ClientPost")
              .doc(location)
              .collection("Posts")
              .doc(postId)
              .update({
                "likeNbr": FieldValue.increment(1),
                "whoLiked": FieldValue.arrayUnion([userId]),
              });
        } else {
          await firestoreRef.collection("InvestorPosts").doc(postId).update({
            "likeNbr": FieldValue.increment(1),
            "whoLiked": FieldValue.arrayUnion([userId]),
          });
        }
      } else {
        if (type == "Client") {
          await firestoreRef
              .collection("ClientPost")
              .doc(location)
              .collection("Posts")
              .doc(postId)
              .update({
                "likeNbr": FieldValue.increment(-1),
                "whoLiked": FieldValue.arrayRemove([userId]),
              });
        } else {
          await firestoreRef.collection("InvestorPosts").doc(postId).update({
            "likeNbr": FieldValue.increment(-1),
            "whoLiked": FieldValue.arrayRemove([userId]),
          });
        }
      }
    } on FirebaseException catch (e) {
      AppLogger.e(e.message ?? "like error");

      throw FirestoreException(
        errorMessage: e.message ?? "somthing went worng",
      );
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
          .collection("PostTitle")
          .doc(opinio.postTitle)
          .set({"title": opinio.postTitle});
      await firestoreRef
          .collection("Opinions")
          .doc(opinio.postLocation)
          .collection("PostTitle")
          .doc(opinio.postTitle)
          .collection("PostOpinion")
          .add(opinio.toJson());
    } on FirebaseException catch (e) {
      AppLogger.e(e.message ?? "set Opinion error");

      throw FirestoreException(
        errorMessage: e.message ?? "somthing went wronge try again later",
      );
    }
  }

  @override
  Future<void> setPostForInvestor(PostMoudel post) async {
    final List<String> photosUrl = [];
    String pdfUrl = "";

    try {
      final postref = await firestoreRef
          .collection("InvestorPosts")
          .add(post.toInvestorMap());
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
            AppLogger.e(e.message ?? "setPostForInvestor error");

      throw ServerException(errorMessage: e.message ?? "somthing went wronge try again later",
      );
    } 
  }

  @override
  Future<List<PostMoudel>> getInvestmentPost() async {
    try {
      final snapshot = await firestoreRef.collection("InvestorPosts").get();
      final List<PostMoudel> posts = snapshot.docs
          .map((item) => PostMoudel.fromMapInvestor(item.data()))
          .toList();
      return posts;
    } on FirebaseException catch (e) {
            AppLogger.e(e.message ?? "getInvestmentPost error");

      throw FirestoreException(errorMessage: e.message ?? "somthing went wronge try again later.");
    }
  }
}
