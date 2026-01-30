import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/core/usecases/baseusecase.dart';
import 'package:makarr/navigation_root/domain/entities/post.dart';
import 'package:makarr/navigation_root/presentation/controler/navigation_provider.dart';

class GetPostState {
  GetPostState({required this.post, this.isLoading = false, this.error});
  final List<Post> post;
  final bool isLoading;
  final String? error;
  GetPostState copyWith({List<Post>? post, bool? isLoading, String? error}) {
    return GetPostState(
      post: post ?? this.post,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory GetPostState.empty() {
    return GetPostState(post: [], isLoading: false, error: null);
  }
}

class GetPostnotifire extends StateNotifier<GetPostState> {
  GetPostnotifire({required this.getPostUsecase}) : super(GetPostState.empty());
  final UseCase<List<Post>, NoParameters > getPostUsecase;
  Future<void> getPost() async {
    state = state.copyWith(isLoading: true, error: null);
    final resulr = await getPostUsecase.call(const NoParameters());
    state = resulr.fold(
      (l) {
        return state.copyWith(isLoading: false, error: l.message);
      },
      (r) {
        return state.copyWith(isLoading: false, post: r);
      },
    );
  }
}

final getPostNotifireProvider =
    StateNotifierProvider<GetPostnotifire, GetPostState>((ref) {
      final getPostUsecase = ref.watch(getPostUsecaseProvider);
      return GetPostnotifire(getPostUsecase: getPostUsecase);
    });
