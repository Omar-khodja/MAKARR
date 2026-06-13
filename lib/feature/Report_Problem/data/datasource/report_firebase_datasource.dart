import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/feature/Report_Problem/data/datasource/report_base_datasource.dart';
import 'package:makarr/feature/Report_Problem/data/model/report_model.dart';

class FireBaseDataSource implements ReportBaseDataSource {
  FireBaseDataSource({required this.firestoreRef, required this.storageRef});
  final FirebaseFirestore firestoreRef;
  final FirebaseStorage storageRef;
  @override
  Future<void> setReport(ReportModel report) async {
    try {
      await firestoreRef.collection("Report").add(report.toMap());
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: e.message ?? "server error");
    }
  }
}
