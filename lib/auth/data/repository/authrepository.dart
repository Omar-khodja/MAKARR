import 'package:dartz/dartz.dart';
import 'package:makarr/auth/data/datasource/base_data_sourse.dart';
import 'package:makarr/auth/data/model/user_auth_model.dart';
import 'package:makarr/auth/domain/repository/base_auth_repo.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/core/error/failure.dart';

class Authrepository extends BaseAuthRepo {
  Authrepository({required this.baseDataSourse});
  final BaseDataSourse baseDataSourse;

  @override
  Future<Either<Failure, Unit>> createUser(user) async {
    try {
      final usermodel = UserAuthModel.fromEntity(user);
      await baseDataSourse.createUser(usermodel);
      return const Right(unit);
    } on AuthException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> login(String email, String password) async {
    try {
      await baseDataSourse.login(email, password);
      return const Right(unit);
    } on AuthException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> singOut() async {
    try {
      await baseDataSourse.singOut();
      return const Right(unit);
    } on AuthException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }
}
