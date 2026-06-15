import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/core/models/opinion_model.dart';
import 'package:makarr/feature/notification/data/datasource/basr_notification_datasource.dart';

class NotificationsDatasource extends BaseNotificationDataSource {
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  @override
  Future<List<String>> getLocation() async {
    try {
      final snapshot = await firestoreRef.collection("Opinions").get();

      final List<String> titles = snapshot.docs
          .map((items) => items.id)
          .toList();
      return titles;
    } on FirebaseException catch (e) {
      throw FirestoreException(
        errorMessage: e.message ?? "cant featch posts for unkown reason!",
      );
    }
  }

  @override
   Future<List<String>> getPostTitles(String location) async {
    try {
      final snapshot = await firestoreRef
          .collection("Opinions")
          .doc(location)
          .collection("PostTitle")
          .get();

      final List<String> titles = snapshot.docs
          .map((items) => items.id)
          .toList();
      return titles;
    } on FirebaseException catch (e) {

      throw FirestoreException(
        errorMessage: e.message ?? "cant featch posts titles for unkown reason!",
      );
    }
  }

  @override
  Future<List<OpinionModel>> getOptions(String postTitle,String location) async{
   try {
      final snapshot = await firestoreRef
          .collection("Opinions")
          .doc(location)
          .collection("PostTitle")
          .doc(postTitle).collection("PostOpinion").get();

      final List<OpinionModel> titles = snapshot.docs.map((item) => OpinionModel.fromJson(item.data(),item.id) ,).toList();
      return titles;
    } on FirebaseException catch (e) {
      throw FirestoreException(
        errorMessage:
            e.message ?? "cant featch posts titles for unkown reason!",
      );
    }
  }
}
