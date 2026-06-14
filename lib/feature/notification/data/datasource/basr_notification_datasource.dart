import 'package:makarr/core/models/opinion_model.dart';

abstract class BaseNotificationDataSource {
  Future<OpinionModel> getOpinion();
   Future<List<String>> getLocation();
}
