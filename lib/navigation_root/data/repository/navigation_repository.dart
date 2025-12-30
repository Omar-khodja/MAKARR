import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/navigation_root/data/datasource/base_datasource.dart';
import 'package:makarr/navigation_root/data/model/report_model.dart';
import 'package:makarr/navigation_root/domain/entities/report.dart';
import 'package:makarr/navigation_root/domain/entities/user.dart';
import 'package:makarr/navigation_root/domain/repository/base_navigation_repository.dart';
import 'package:geocoding/geocoding.dart';


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

  @override
  Future<Either<Failure, void>> setReportToDataBase(Report report) async{
    try{
        final reportmodel = ReportModel.fromEntity(report);
      await baseDataSource.setReport(reportmodel);
      return const Right(null);
    }catch(e){
      return const Left(ServerFailure("Failed to set report"));
    }
  }
  
  @override
  Future<Either<Failure, Map<String , dynamic>>> getCurrentLocation() async{
    bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
  
    return const Left(GpsFailure('Location services are disabled. please open GPS'));
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      return const Left(GpsFailure('Location permissions are denied') );
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return const Left(GpsFailure(
      'Location permissions are permanently denied, we cannot request permissions.'));
  } 
  final Position position = await Geolocator.getCurrentPosition();
  final List<Placemark> result = await placemarkFromCoordinates(position.latitude , position.longitude);
  if(result.isEmpty) return const Left(GpsFailure("Unknown location")) ;
  final placemark = result.first;

    return Right({
      "lat": position.latitude,
      "lng": position.longitude,
      "address": placemark.administrativeArea,
    });
  }
}