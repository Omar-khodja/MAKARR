import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:makarr/feature/notification/domain/usecase/getlocations_usecase.dart';
import 'package:makarr/feature/notification/presentation/controler/notification_provider.dart';

class LocationNotifireProvider extends StateNotifier<AsyncValue<List<String>>> {
  LocationNotifireProvider({required this.useCase})
    : super(const AsyncValue.loading());
  final GetlocationsUsecase useCase;
  Future<void> getLocations() async {
    state = const AsyncValue.loading();

    final result = await useCase.getlocation();
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

final locationProvider =
    StateNotifierProvider<LocationNotifireProvider, AsyncValue<List<String>>>(
      (ref) => LocationNotifireProvider(
        useCase: ref.read(getLocationUseCaseProvider),
      ),
    );
