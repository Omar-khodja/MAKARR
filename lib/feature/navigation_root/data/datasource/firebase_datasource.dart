import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/feature/navigation_root/data/datasource/base_datasource.dart';
import 'package:makarr/feature/navigation_root/data/model/report_model.dart';
import 'package:makarr/feature/navigation_root/data/model/user_model.dart';

class FirebaseDatasource implements BaseDataSource {
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      final result = await firestoreRef.collection("Users").doc(userId).get();
      if (result.exists && result.data() != null) {
        return UserModel.fromFireBase(result.data()!);
      } else {
        throw const FirestoreException(errorMessage: 'User dose not exist');
      }
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: e.message ?? 'Server error');
    }
  }

  @override
  Future<void> setReport(ReportModel report) async {
    try {
      await firestoreRef.collection("Report").add(report.toMap());
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: e.message ?? "server error");
    }
  }

  @override
  Future<String> updateProfileImage(File imageFile, String userId) async {
    try {
      final ref = storageRef.ref().child('profile_images/$userId.jpg');
      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();
      await firestoreRef.collection("Users").doc(userId).update(({
        'ImagUrl': imageUrl,
      }));
      return imageUrl;
    } on FirebaseException catch (e) {
      if (e.plugin == 'firebase_storage') {
        throw StorageException(errorMessage: "Storge error ${e.message}");
      } else if (e.plugin == 'cloud_firestore') {
        throw FirestoreException(errorMessage: "Firestore error ${e.message}");
      } else {
        throw ServerException(
          errorMessage: 'An unexpected server error occurred: ${e.message}',
        );
      }
    } catch (e) {
      throw ServerException(errorMessage: 'An unexpected error occurred: $e');
    }
  }


}
