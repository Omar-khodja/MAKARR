import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makarr/auth/data/datasource/base_data_sourse.dart';
import 'package:makarr/auth/data/model/user_model.dart';
import 'package:makarr/core/error/exeptions.dart';

class FirebaseDatasource extends BaseDataSourse {
  @override
  Future<void> createUser(UserModel user) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
            'UserId': user.id.trim(),
            'Fname': user.firstName.trim(),
            'Lname': user.lastName.trim(),
            'Phone': user.phone.trim(),
            'Birth_Date': user.birthDate.trim(),
            'Email': user.email.trim(),
            'ImagUrl': "",
          });
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Auth error');
    } on FirebaseException catch (e) {
      throw ServerException(errorMessage: e.message ?? 'Server error');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Auth error');
    }
  }

  @override
  Future<void> singOut() async{
    try {
    await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Auth error');
    }
  }
}
