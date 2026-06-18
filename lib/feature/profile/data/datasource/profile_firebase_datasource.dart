import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/feature/profile/data/datasource/base_profile_datasource.dart';
import 'package:makarr/feature/profile/data/model/user_model.dart';

class FirebaseDatasource implements BaseDataSource {
  FirebaseDatasource({required this.firestoreRef, required this.storageRef});
  final FirebaseFirestore firestoreRef;
  final FirebaseStorage storageRef;
  @override
  Future<UserModel> getUserById(String userId) async {
    AppLogger.i(userId);
    try {
      final result = await firestoreRef.collection("Users").doc(userId).get();
        return UserModel.fromFireBase(result.data()!);
    
    } on FirebaseException catch (e) {
      AppLogger.e(e.code);
      throw FirestoreException(errorMessage: e.message ?? 'Server error');
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
