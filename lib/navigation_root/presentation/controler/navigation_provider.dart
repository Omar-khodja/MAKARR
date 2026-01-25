import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/navigation_root/data/datasource/base_datasource.dart';
import 'package:makarr/navigation_root/data/datasource/firebase_datasource.dart';
import 'package:makarr/navigation_root/data/repository/navigation_repository.dart';
import 'package:makarr/navigation_root/domain/repository/base_navigation_repository.dart';
import 'package:makarr/navigation_root/domain/usecase/featch_current_user_usercase.dart';
import 'package:makarr/navigation_root/domain/usecase/set_report_usecase.dart';

final baseDataSource = Provider<BaseDataSource>((ref) => FirebaseDatasource());

final navigationRepository = Provider<BaseNavigationRepository>(
  (ref) => NavigationRepository(baseDataSource: ref.read(baseDataSource)),
);

///UseCases provider
final featchCurrentUserUsercaseProvider = Provider<FeatchCurrentUserUsercase>(
  (ref) => FeatchCurrentUserUsercase(
    baseNavigationRepository: ref.read(navigationRepository),
  ),
);
final setReportUsecaseProvider = Provider<SetReportUsecase>(
  (ref) => SetReportUsecase(ref.read(navigationRepository)),
);
