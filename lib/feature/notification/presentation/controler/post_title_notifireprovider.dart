import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/feature/notification/domain/usecase/get_posttitle_usecase.dart';
import 'package:makarr/feature/notification/presentation/controler/notification_provider.dart';

class PostTitleNotifireprovider
    extends StateNotifier<AsyncValue<List<String>>> {
  PostTitleNotifireprovider({required this.usecase})
    : super(const AsyncValue.loading());
  final GetPosttitleUsecase usecase;
  Future<void> gettitles(String location) async {
    final result = await usecase.getPostTitile(location);
    state = result.fold(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => AsyncValue.data(r),
    );
  }
}

final postTitleprovider =
    StateNotifierProvider<PostTitleNotifireprovider, AsyncValue<List<String>>>(
      (ref) => PostTitleNotifireprovider(
        usecase: ref.read(postTitileUseCaseProvider),
      ),
    );
