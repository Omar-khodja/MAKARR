import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/Report_Problem/domain/usecase/set_report_usecase.dart';
import 'package:makarr/feature/Report_Problem/presentation/controler/_provider.dart';

class LocationNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  LocationNotifier({required this.setReport})
    : super(const AsyncValue.data({}));

  final SetReportUsecase setReport;

  Future<void> getCurrentLocation() async {
    // show loading state
    state = const AsyncValue.loading();

    final Either<Failure, Map<String, dynamic>> result = await setReport
        .getCurrentLocation();

    result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.message, backgroundColor: Colors.red);
        state =const  AsyncValue.data({});
      },
      (r) {
        state = AsyncValue.data(r);
      },
    );
  }
    Future<void> emptyState()  async{
    state = const  AsyncValue.data({});
  }
}

final locationNotifierProvider =
    StateNotifierProvider<LocationNotifier, AsyncValue<Map<String, dynamic>>>(
      (ref) => LocationNotifier(setReport: ref.read(setReportUsecaseProvider)),
    );
