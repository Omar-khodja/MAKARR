import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makarr/auth/data/datasource/base_data_sourse.dart';
import 'package:makarr/auth/data/model/user_model.dart';
import 'package:makarr/core/error/exeptions.dart';

class FirebaseDatasource extends BaseDataSourse {
  @override
  Future<void> createUser(String email, String password, UserModel user) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
            'UserId': user.id.trim(),
            'Fname': user.firstName.trim(),
            'Lname': user.lastName.trim(),
            'Phone': user.phone.trim(),
            'Birth_Date': user.birthDate.trim(),
            'Email': email.trim(),
            'ImagUrl': "",
          });
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Auth error');
    } on  FirebaseException catch (e) {
      throw ServerException(errorMessage: e.message ?? 'Server error');
    }
  }

  @override
  Future<UserModel> getUserById(String userid) {
    try {
      final doc =
          FirebaseFirestore.instance.collection("Users").doc(userid);
      return doc.get().then((documentSnapshot) {
        if (documentSnapshot.exists) {
          final data = documentSnapshot.data()!;
          return UserModel.fromfirebase(data);
        } else {
          throw const ServerException(errorMessage: 'User not found');
        }
      });
    } on FirebaseException catch (e) {
      throw ServerException(errorMessage: e.message ?? 'Server error');
    }
  }

  @override
  Future<void> login(String email, String password) {
    try {
      return FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Auth error');
    }
  }
}
