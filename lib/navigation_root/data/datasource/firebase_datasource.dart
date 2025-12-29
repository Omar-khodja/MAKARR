import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/navigation_root/data/datasource/base_datasource.dart';
import 'package:makarr/navigation_root/data/model/report_model.dart';
import 'package:makarr/navigation_root/data/model/user_model.dart';

class FirebaseDatasource implements BaseDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      final result = await firestore.collection("Users").doc(userId).get();
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
      await firestore.collection("Report").add(report.toMap());
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: e.message ?? "server error");
    }
  }
}
