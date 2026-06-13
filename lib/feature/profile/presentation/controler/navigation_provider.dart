import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/profile/data/datasource/base_profile_datasource.dart';
import 'package:makarr/feature/profile/data/datasource/profile_firebase_datasource.dart';
import 'package:makarr/feature/profile/data/repository/profile_repository.dart';
import 'package:makarr/feature/profile/domain/repository/base_profile_repository.dart';
import 'package:makarr/feature/profile/domain/usecase/featch_current_user_usercase.dart';

final baseDataSource = Provider<BaseDataSource>((ref) {
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  return FirebaseDatasource(firestoreRef: firestoreRef, storageRef: storageRef);
});

final navigationRepository = Provider<BaseNavigationRepository>(
  (ref) => NavigationRepository(baseDataSource: ref.read(baseDataSource)),
);

///UseCases provider
final featchCurrentUserUsercaseProvider = Provider<FeatchCurrentUserUsercase>(
  (ref) => FeatchCurrentUserUsercase(
    baseNavigationRepository: ref.read(navigationRepository),
  ),
);

////////PhotoViewCacheManager
