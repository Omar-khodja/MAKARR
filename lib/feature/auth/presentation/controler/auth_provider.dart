import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/feature/auth/data/datasource/base_data_sourse.dart';
import 'package:makarr/feature/auth/data/datasource/firebase_datasource.dart';
import 'package:makarr/feature/auth/data/repository/authrepository.dart';
import 'package:makarr/feature/auth/domain/repository/base_auth_repo.dart';
import 'package:makarr/feature/auth/domain/usecase/createuser_usecase.dart';
import 'package:makarr/feature/auth/domain/usecase/login_usecase.dart';
import 'package:makarr/feature/auth/domain/usecase/singout_usecase.dart';

/// BaseDataSourse provider
final baseDataSourceProvider = Provider<BaseDataSourse>(
  (ref) => FirebaseDatasource(),
);

///BaseAuthRepo provider
final authRepositoryProvider = Provider<BaseAuthRepo>(
  (ref) => Authrepository(baseDataSourse: ref.read(baseDataSourceProvider)),
);

///user cases provider
final createUserUseCaseProvider = Provider(
  (ref) {
   AppLogger.i("createUserUseCaseProvider initialized");
  return CreateuserUsecase(baseAuthRepo: ref.read(authRepositoryProvider));
  } 
);
final loginUseCaseProvider = Provider(
  (ref)  {
       AppLogger.i("loginUseCaseProvider initialized");

    return LoginUsecase(baseAuthRepo: ref.read(authRepositoryProvider));
  }
);

final singOutUseCaseProvider = Provider(
  (ref) => SingoutUsecase(baseAuthRepo: ref.read(authRepositoryProvider)),
);
