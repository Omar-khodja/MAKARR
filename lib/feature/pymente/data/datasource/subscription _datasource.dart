import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/feature/pymente/data/datasource/base_subscription%20_datasource.dart';

class SubSubscriptionDatasource implements BasesubscriptionDatasource {
  SubSubscriptionDatasource();
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;

  @override
  Future<String> subscription(String plan, String userId) async {
    DateTime endDate = DateTime.now().add(const Duration(days: 90));
    try {
      await firestoreRef.collection("Users").doc(userId).update(({
        'subscription': endDate.toString(),
      }));
      return "subscribes successfully ";
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: e.message ?? "Unkown error");
    }
  }

  @override
  Future<String> checksubscription(String userId) async {
    try {
      final snapshot = await firestoreRef.collection("Users").doc(userId).get();
      final subscription = snapshot.data()?["subscription"];
      return subscription;
    } on FirebaseException catch (e) {
      throw FirestoreException(errorMessage: e.message ?? "Unkown error");
    }
  }
}
