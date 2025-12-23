import 'package:dartz/dartz.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/navigation_root/data/datasource/base_datasource.dart';
import 'package:makarr/navigation_root/domain/entities/user.dart';
import 'package:makarr/navigation_root/domain/repository/base_navigation_repository.dart';

class NavigationRepository extends BaseNavigationRepository {
  NavigationRepository({required this.baseDataSource});
  final BaseDataSource baseDataSource;

  @override
  
  Future<Either<Failure,User>> getCurrentUserInfo(String userId)async {
    try{
      final user =await baseDataSource.getUserById(userId);
      return Right(user);

    }catch(e){
      return const Left(ServerFailure('Failed to fetch user data'));
    }
    
  }
}