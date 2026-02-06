



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/post/data/datasource/base_datasource_post.dart';
import 'package:makarr/feature/post/data/datasource/firebase_datasource.dart';
import 'package:makarr/feature/post/data/repository/post_repo.dart';
import 'package:makarr/feature/post/domain/repository/base_post_repo.dart';
import 'package:makarr/feature/post/domain/usecase/get_post_usecase.dart';
import 'package:makarr/feature/post/domain/usecase/set_post_usecase.dart';

final baseDataSource = Provider<BaseDatasourcePost>((ref) => FirebaseDatasource());

final navigationRepository = Provider<BasePostRepo>(
  (ref) => PostRepo(baseDataSourcepost: ref.read(baseDataSource)),
);
////usecase
final setPostUsecaseProvider = Provider<SetPostUsecase>(
  (ref) => SetPostUsecase(ref.read(navigationRepository)),
);
final getPostUsecaseProvider = Provider<GetPostUsecase>(
  (ref) => GetPostUsecase(ref.read(navigationRepository)),
);
