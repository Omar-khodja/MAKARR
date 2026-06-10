import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/feature/auth/data/datasource/base_data_sourse.dart';
import 'package:makarr/feature/auth/data/model/user_auth_model.dart';
import 'package:makarr/core/error/exeptions.dart';

class FirebaseDatasource extends BaseDataSourse {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUser(UserAuthModel user) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await firestore.collection("Users").doc(userCredential.user!.uid).set({
        "id" : userCredential.user!.uid,
        'Fname': user.firstName.trim(),
        'Lname': user.lastName.trim(),
        'Phone': user.phone.trim(),
        'Birth_Date': user.birthDate.trim(),
        'Email': user.email.trim(),
        'Wilaya': user.wilaya.trim(),
        'Bladya': user.bladya.trim(),
        'ImagUrl': "",
        'type':"Client"
      });
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorMessage: e.message ?? 'Auth error');
    } on FirebaseException catch (e) {
      throw ServerException(errorMessage: e.message ?? 'Server error');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      AppLogger.i("Attempting to log in with email: $email,$password");
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const AuthException(
          errorMessage: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        throw const AuthException(errorMessage: 'Wrong password provided.');
      } else if (e.code == 'invalid-email') {
        throw const AuthException(errorMessage: 'Invalid email format.');
      } else {
        throw AuthException(errorMessage: e.message ?? 'Auth error');
      }
    }
  }

  @override
  Future<void> singOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorMessage: e.message ?? 'Auth error');
    }
  }
}
