import 'package:dartz/dartz.dart';
import 'package:makarr/auth/domain/repository/base_auth_repo.dart';
import 'package:makarr/core/error/failure.dart';

class SingoutUsecase {
  SingoutUsecase({required this.baseAuthRepo});
  final BaseAuthRepo baseAuthRepo;

  Future<Either<Failure, Unit>> call() async {
    return await baseAuthRepo.singOut();
  }
}
