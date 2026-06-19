import 'package:makarr/core/models/opinion_model.dart';
import 'package:makarr/feature/Report_Problem/data/model/report_model.dart';

abstract class BaseNotificationDataSource {
  Future<List<String>> getPostTitles(String location);
  Future<List<String>> getLocation();
  Future<List<OpinionModel>> getOptions(String postTitle, String location);
  Future<List<String>> getReportLocation();
    Future<List<ReportModel>> getReport(String location);

}
