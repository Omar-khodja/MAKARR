import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/core/entities/opinion.dart';
import 'package:makarr/feature/notification/domain/usecase/get_opinion_usecase.dart';
import 'package:makarr/feature/notification/presentation/controler/notification_provider.dart';

class OpinionNotifireProvider extends StateNotifier<AsyncValue<List<Opinion>>> {
  OpinionNotifireProvider({required this.usecase})
    : super(const AsyncValue.loading());
  final GetOpinionUsecase usecase;

  Future<void> getOpinion(String postTitle, String location) async {
    final result = await usecase.getOpinion(postTitle, location);
    state = result.fold(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => AsyncValue.data(r),
    );
  }
}

final opinionsProvider = StateNotifierProvider(
  (ref) =>
      OpinionNotifireProvider(usecase: ref.read(getOpinionUseCaseProvider)),
);
