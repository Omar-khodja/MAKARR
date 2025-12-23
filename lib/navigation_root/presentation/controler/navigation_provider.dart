import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/navigation_root/data/datasource/base_datasource.dart';
import 'package:makarr/navigation_root/data/datasource/firebase_datasource.dart';
import 'package:makarr/navigation_root/data/repository/navigation_repository.dart';
import 'package:makarr/navigation_root/domain/repository/base_navigation_repository.dart';
import 'package:makarr/navigation_root/domain/usecase/featch_current_user_usercase.dart';

final baseDataSource = Provider<BaseDataSource>((ref) => FirebaseDatasource());

final baseNavigationRepository = Provider<BaseNavigationRepository>(
  (ref) => NavigationRepository(baseDataSource: ref.read(baseDataSource)),
);
 

 final featchCurrentUserUsercaseProvider = Provider<FeatchCurrentUserUsercase>(
   (ref) => FeatchCurrentUserUsercase(
     baseNavigationRepository: ref.read(baseNavigationRepository),
   ),
 );
