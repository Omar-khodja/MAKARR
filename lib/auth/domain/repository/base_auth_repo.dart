import 'package:dartz/dartz.dart';
import 'package:makarr/auth/domain/entities/user.dart';
import 'package:makarr/core/error/failure.dart';

abstract class BaseAuthRepo {
  Future<Either<Failure, Unit>> createUser( User user);
  Future<Either<Failure, Unit>> login(String email, String password);
  Future<Either<Failure, Unit>> singOut();
}
