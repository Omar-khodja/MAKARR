import 'package:dartz/dartz.dart';
import 'package:makarr/feature/auth/domain/repository/base_auth_repo.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/core/usecases/baseusecase.dart';

class SingoutUsecase implements UseCase<void, NoParameters> {
  SingoutUsecase({required this.baseAuthRepo});
  final BaseAuthRepo baseAuthRepo;
  @override
  Future<Either<Failure, void>> call(NoParameters  params) async {
    return await baseAuthRepo.singOut();
  }
}
