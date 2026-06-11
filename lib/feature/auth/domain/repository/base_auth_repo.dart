import 'package:dartz/dartz.dart';
import 'package:makarr/feature/auth/domain/entities/user_auth.dart';
import 'package:makarr/core/error/failure.dart';

abstract class BaseAuthRepo {
  Future<Either<Failure, void>> createUser(UserAuth user);
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, void >> singOut();
}
