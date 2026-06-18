import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makarr/feature/pymente/domain/usecase/subscription_usecase.dart';
import 'package:makarr/feature/pymente/presentation/controler/subscription_provider.dart';

class Subscriptionnotifire extends StateNotifier<AsyncValue<bool>> {
  Subscriptionnotifire({required this.usecase})
    : super(const AsyncValue.loading());
  final SubscriptionUsecase usecase;
  Future<bool> subscription(String plan, String userId) async {
    final result = await usecase.subscription(plan, userId);
    return result.fold(
      (l) {
        Fluttertoast.showToast(msg: l.toString());
        return false;
      },
      (r) {
        Fluttertoast.showToast(msg: "subscribed successfully");
        return true;
      },
    );
  }

  Future<void> checkSubscription(String userId) async {
    final result = await usecase.checkSubscription(userId);
    state = result.fold(
      (l) {
        return AsyncValue.error(l,StackTrace.current);
      },
      (isExpired) {
       return  AsyncValue.data(isExpired);
      },
    );
  }
}

final subscriptionProvider = StateNotifierProvider(
  (ref) => Subscriptionnotifire(usecase: ref.read(subSubscriptionUserCase)),
);
