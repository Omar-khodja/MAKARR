import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:makarr/feature/notification/domain/usecase/getlocations_usecase.dart';
import 'package:makarr/feature/notification/presentation/controler/notification_provider.dart';

class ReportLocationNotifire extends StateNotifier<AsyncValue<List<String>>> {
  ReportLocationNotifire({required this.useCase})
    : super(const AsyncValue.loading());
  final GetlocationsUsecase useCase;
  Future<void> getLocations() async {
    state = const AsyncValue.loading();

    final result = await useCase.getReportLocation();
    state = result.fold((l) {
      Fluttertoast.showToast(
        msg: 'Faild To featch Locations',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return AsyncValue.error("Faild To featch Locations", StackTrace.current);
    }, (r) => AsyncValue.data(r));
  }
}

final reportLocationProvider =
    StateNotifierProvider<ReportLocationNotifire, AsyncValue<List<String>>>(
      (ref) => ReportLocationNotifire(
        useCase: ref.read(getLocationUseCaseProvider),
      ),
    );
