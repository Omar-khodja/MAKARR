import 'package:makarr/core/models/report_model.dart';

abstract class ReportBaseDataSource {
  Future<bool> setReport(ReportModel report);
}
