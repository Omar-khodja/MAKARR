import 'package:dartz/dartz.dart';
import 'package:makarr/feature/auth/domain/entities/user_auth.dart';
import 'package:makarr/feature/auth/domain/repository/base_auth_repo.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';

class CreateuserUsecase implements UseCase<void, UserAuth> {
  CreateuserUsecase({required this.baseAuthRepo});
  final BaseAuthRepo baseAuthRepo;
  @override
  Future<Either<Failure, void>> setOpinion(UserAuth user) async {
    return await baseAuthRepo.createUser(user);
  }
}
