import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/feature/Report_Problem/data/datasource/report_base_datasource.dart';
import 'package:makarr/feature/Report_Problem/data/model/report_model.dart';

class FireBaseDataSource implements ReportBaseDataSource {
  FireBaseDataSource({required this.firestoreRef, required this.storageRef});
  final FirebaseFirestore firestoreRef;
  final FirebaseStorage storageRef;
  @override
  Future<bool> setReport(ReportModel report) async {
    final List<String> photosUrl = [];
    AppLogger.i("here");
    try {
      final reportRef = await firestoreRef
          .collection("Report")
          .doc(report.address)
          .collection("Reports")
          .add(report.toMap());
      if (report.images.isNotEmpty == true) {
        for (int i = 0; i < report.images.length; i++) {
          final imageRef = storageRef.ref().child(
            'report_images/${reportRef.id}/image_$i.jpg',
          );
          await imageRef.putFile(report.images[i]);
          final imageUrl = await imageRef.getDownloadURL();
          photosUrl.add(imageUrl);
        }
      }
      await reportRef.update({"Images": photosUrl});
      return true;
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: e.message ?? "server error");
    }
  }
}
