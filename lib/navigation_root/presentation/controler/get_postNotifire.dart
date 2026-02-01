import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/navigation_root/domain/entities/post.dart';
import 'package:makarr/navigation_root/presentation/controler/navigation_provider.dart';

class GetPostnotifire extends StateNotifier<AsyncValue<List<Post>>> {
  GetPostnotifire({required this.getPostUsecase})
    : super(const AsyncValue.loading());
  final UseCase<List<Post>, NoParameters> getPostUsecase;
  Future<void> getPost() async {
    state = const AsyncValue.loading();
    
    await Future.delayed(const Duration(seconds: 5));
    final resulr = await getPostUsecase.call(const NoParameters());
    state = resulr.fold(
      (failure) {
        return AsyncValue.error(failure.message, StackTrace.current);
      },
      (posts) {
        return AsyncValue.data(posts);
      },
    );
  }
}

final getPostNotifireProvider =
    StateNotifierProvider<GetPostnotifire, AsyncValue<List<Post>>>((ref) {
      final getPostUsecase = ref.watch(getPostUsecaseProvider);
      return GetPostnotifire(getPostUsecase: getPostUsecase);
    });
