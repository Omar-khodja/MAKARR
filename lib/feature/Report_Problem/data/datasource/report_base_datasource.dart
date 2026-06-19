import 'package:makarr/feature/Report_Problem/data/model/report_model.dart';

abstract class ReportBaseDataSource {
  Future<bool> setReport(ReportModel report);
}
