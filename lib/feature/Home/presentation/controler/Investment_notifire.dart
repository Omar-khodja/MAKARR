import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/domain/usecase/get_post_usecase.dart';
import 'package:makarr/feature/Home/presentation/controler/post_provider.dart';

class InvestmentNotifire extends StateNotifier<AsyncValue<List<Post>>> {
  InvestmentNotifire({required this.getPostUsecase})
    : super(const AsyncValue.loading());
  final GetPostUsecase getPostUsecase;

  Future<void> getInvestmentPost() async {
    state = const AsyncValue.loading();

    await Future.delayed(const Duration(seconds: 3));
    final resulr = await getPostUsecase.getInvestmentPost();
    state = resulr.fold(
      (failure) {
        return AsyncValue.error(failure.message, StackTrace.current);
      },
      (posts) {
        return AsyncValue.data(posts);
      },
    );
  }
    Future<void> setLike(String userId, Post targetPost) async {
    final like = targetPost.whoLiked.contains(userId);
    state = state.whenData((posts) {
      return posts.map((post) {
        if (post.id == targetPost.id) {
          if (like) {
            return post.copyWith(
              likeNbr: (post.likeNbr ?? 0) - 1,
              whoLiked: post.whoLiked
                  .where((element) => element != userId)
                  .toList(),
            );
          } else {
            return post.copyWith(
              likeNbr: (post.likeNbr ?? 0) + 1,
              whoLiked: [...post.whoLiked, userId],
            );
          }
        }
        return post;
      }).toList();
    });
    await getPostUsecase.setLike(userId, targetPost, "Investment");
  }
}

final investmentNotifireProvider =
    StateNotifierProvider<InvestmentNotifire, AsyncValue<List<Post>>>((ref) {
      final getPostUsecase = ref.watch(getPostUsecaseProvider);
      return InvestmentNotifire(getPostUsecase: getPostUsecase);
    });

