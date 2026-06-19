import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makarr/feature/Report_Problem/domain/entities/report.dart';
import 'package:makarr/feature/Report_Problem/domain/usecase/set_report_usecase.dart';
import 'package:makarr/feature/Report_Problem/presentation/controler/_provider.dart';

class Reportnotifire extends StateNotifier<AsyncValue<bool>> {
  Reportnotifire({required this.usecase}) : super(const AsyncValue.data(true));
  final SetReportUsecase usecase;

  Future<bool> setReport(Report report) async {
    state = const AsyncValue.loading();
    final result = await usecase.setReport(report);
   return result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.message, backgroundColor: Colors.red);
        state = const AsyncValue.data(false);
        return false;
      },
      (r) {
        Fluttertoast.showToast(msg: "Report sent successfully");
        state = AsyncValue.data(r);
        return true;
      },  
    );
  }

}

final reportNotifireProvider =
    StateNotifierProvider<Reportnotifire, AsyncValue<void>>(
      (ref) => Reportnotifire(usecase: ref.read(setReportUsecaseProvider)),
    );
