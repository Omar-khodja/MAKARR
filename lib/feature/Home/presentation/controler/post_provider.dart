



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/Home/data/datasource/base_datasource_post.dart';
import 'package:makarr/feature/Home/data/datasource/firebase_datasource.dart';
import 'package:makarr/feature/Home/data/repository/post_repo.dart';
import 'package:makarr/feature/Home/domain/repository/base_post_repo.dart';
import 'package:makarr/feature/Home/domain/usecase/get_post_usecase.dart';
import 'package:makarr/feature/Home/domain/usecase/set_post_usecase.dart';

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
