import 'package:dartz/dartz.dart';
import 'package:makarr/auth/domain/entities/user_auth.dart';
import 'package:makarr/auth/domain/repository/base_auth_repo.dart';
import 'package:makarr/core/error/failure.dart';

class CreateuserUsecase {
  CreateuserUsecase({required this.baseAuthRepo});
  final BaseAuthRepo baseAuthRepo;

  Future<Either<Failure, Unit>> call(UserAuth user) async {
    return await baseAuthRepo.createUser(user);
  }
}
