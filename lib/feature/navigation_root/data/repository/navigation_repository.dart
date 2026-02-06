import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/error/exeptions.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/navigation_root/data/datasource/base_datasource.dart';
import 'package:makarr/feature/navigation_root/data/model/report_model.dart';
import 'package:makarr/feature/navigation_root/domain/entities/report.dart';
import 'package:makarr/feature/navigation_root/domain/entities/user_nav.dart';
import 'package:makarr/feature/navigation_root/domain/repository/base_navigation_repository.dart';
import 'package:dio/dio.dart';

class NavigationRepository extends BaseNavigationRepository {
  NavigationRepository({required this.baseDataSource});
  final BaseDataSource baseDataSource;

  @override
  Future<Either<Failure, UserNav>> getCurrentUserInfo(String userId) async {
    try {
      final user = await baseDataSource.getUserById(userId);
      return Right(user);
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch user data'));
    }
  }

  @override
  Future<Either<Failure, void>> setReportToDataBase(Report report) async {
    try {
      final reportmodel = ReportModel.fromEntity(report);
      await baseDataSource.setReport(reportmodel);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure("Failed to set report"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCurrentLocation() async {
    final dio = Dio();
    bool serviceEnabled;
    LocationPermission permission;
    final apikey = dotenv.env["API_KEY"];

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const Left(
        GpsFailure('Location services are disabled. please open GPS'),
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const Left(GpsFailure('Location permissions are denied'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return const Left(
        GpsFailure(
          'Location permissions are permanently denied, we cannot request permissions.',
        ),
      );
    }
    try {
      final Position position = await Geolocator.getCurrentPosition();
      final response = await dio.get(
        "https://api.opencagedata.com/geocode/v1/json?q=${position.latitude}%2C+${position.longitude}&key=$apikey",
      );
      if (response.data == null) {
        return const Left(GpsFailure("Unknown location"));
      }
      final placemark = response.data["results"][0]['components'];

      return Right({
        "lat": position.latitude,
        "lng": position.longitude,
        "formatted":
            "${placemark["road"] == "unnamed road" ? null : placemark["road"]} , ${placemark["suburb"]} , ${placemark["city"]} , ${placemark["state"]}",
      });
    } catch (e) {
      AppLogger.e(e.toString());
      return const Left(
        GpsFailure("can't get current location,try again later !"),
      );
    }
  }

  @override
  Future<Either<Failure, UserNav>> updateProfileImage(
    File imageFile,
    String userId,
    UserNav currentUser,
  ) async {
    try {
      final imageurl = await baseDataSource.updateProfileImage(
        imageFile,
        userId,
      );
      final UserNav user = currentUser.copyWith(imagUrl: imageurl);
      return Right(user);
    } on StorageException catch (e) {
      AppLogger.e(e.errorMessage);
      return Left(ServerFailure(e.errorMessage));
    } on FirestoreException catch (e) {
      AppLogger.e(e.errorMessage);
      return Left(ServerFailure(e.errorMessage));
    } catch (e) {
      AppLogger.e(e.toString());
      return const Left(ServerFailure("Failed to update profile image"));
    }
  }


}
