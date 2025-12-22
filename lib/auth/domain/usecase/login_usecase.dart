import 'package:dartz/dartz.dart';
import 'package:makarr/auth/domain/repository/base_auth_repo.dart';
import 'package:makarr/core/error/failure.dart';

class LoginUsecase {
  LoginUsecase({required this.baseAuthRepo});
  final BaseAuthRepo baseAuthRepo;
  Future<Either<Failure , Unit>> call(String email, String password) async {
    return await baseAuthRepo.login(email, password);
  }
}
