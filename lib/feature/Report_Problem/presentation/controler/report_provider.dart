import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/Report_Problem/data/datasource/report_base_datasource.dart';
import 'package:makarr/feature/Report_Problem/data/datasource/report_firebase_datasource.dart';
import 'package:makarr/feature/Report_Problem/data/repository/report_repo.dart';
import 'package:makarr/feature/Report_Problem/domain/usecase/set_report_usecase.dart';

final reportBaseDataSourceProvider = Provider<ReportBaseDataSource>((ref) {
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  return FireBaseDataSource(firestoreRef: firestoreRef, storageRef: storageRef);
});
final reportRepositoryProvider = Provider(
  (ref) => ReportRepo(ref.read(reportBaseDataSourceProvider)),
);
//////use case
final setReportUsecaseProvider = Provider(
  (ref) => SetReportUsecase(ref.read(reportRepositoryProvider)),
);
