import 'package:dartz/dartz.dart';
import 'package:makarr/feature/auth/domain/repository/base_auth_repo.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';

class LoginUsecase implements UseCase<void, (String, String)> {
  LoginUsecase({required this.baseAuthRepo});
  final BaseAuthRepo baseAuthRepo;
  @override
  Future<Either<Failure, void>> call((String, String) params) async {
    final (email, password) = params;
    return await baseAuthRepo.login(email, password);
  }
}
