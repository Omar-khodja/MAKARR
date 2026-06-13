import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/Report_Problem/data/datasource/report_base_datasource.dart';
import 'package:makarr/feature/Report_Problem/data/model/report_model.dart';
import 'package:makarr/feature/Report_Problem/domain/entities/report.dart';
import 'package:makarr/feature/Report_Problem/domain/repository/base_report_repo.dart';

class ReportRepo implements BaseReportRepo {
  ReportRepo(this.baseDataSource);
  final ReportBaseDataSource baseDataSource;
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
}
