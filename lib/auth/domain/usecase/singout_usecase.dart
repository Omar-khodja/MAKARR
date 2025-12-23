import 'package:dartz/dartz.dart';
import 'package:makarr/auth/domain/repository/base_auth_repo.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';

class SingoutUsecase implements UseCase<Unit, NoParameters> {
  SingoutUsecase({required this.baseAuthRepo});
  final BaseAuthRepo baseAuthRepo;
  @override
  Future<Either<Failure, Unit>> call(NoParameters  params) async {
    return await baseAuthRepo.singOut();
  }
}
