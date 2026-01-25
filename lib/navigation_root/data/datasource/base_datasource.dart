import 'dart:io';

import 'package:makarr/navigation_root/data/model/report_model.dart';
import 'package:makarr/navigation_root/data/model/user_model.dart';

abstract class BaseDataSource {
  Future<UserModel> getUserById(String userId);
  Future<void> setReport(ReportModel report);
  Future<String> updateProfileImage(File imageFile,String userId);

}