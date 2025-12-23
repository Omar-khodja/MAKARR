import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makarr/auth/data/datasource/base_data_sourse.dart';
import 'package:makarr/auth/data/model/user_auth_model.dart';
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
        'UserId': user.id.trim(),
        'Fname': user.firstName.trim(),
        'Lname': user.lastName.trim(),
        'Phone': user.phone.trim(),
        'Birth_Date': user.birthDate.trim(),
        'Email': user.email.trim(),
        'ImagUrl': "",
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
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorMessage: e.message ?? 'Auth error');
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
