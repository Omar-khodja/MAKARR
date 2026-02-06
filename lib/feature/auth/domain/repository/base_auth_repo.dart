import 'package:dartz/dartz.dart';
import 'package:makarr/feature/auth/domain/entities/user_auth.dart';
import 'package:makarr/core/error/failure.dart';

abstract class BaseAuthRepo {
  Future<Either<Failure, Unit>> createUser(UserAuth user);
  Future<Either<Failure, Unit>> login(String email, String password);
  Future<Either<Failure, Unit>> singOut();
}
