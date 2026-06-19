import 'package:makarr/feature/Report_Problem/domain/entities/report.dart';

class ReportModel extends Report {
  const ReportModel({
    required super.titel,
    required super.discreption,
    required super.date,
    required super.images,
    required super.lat,
    required super.lng,
    required super.address,
    required super.userId,
    required super.userName,
    required super.userprofile,
  });
  Map<String, dynamic> toMap() {
    return {
      "Title": titel,
      "Discreption": discreption,
      "Date": date,
      "lat": lat,
      'lng': lng,
      'address': address,
      "Images": '',
      'date': date,
      "userId": userId,
      "userName": userName,
      "userprofile": userprofile,
    };
  }

  factory ReportModel.fromEntity(Report report) {
    return ReportModel(
      titel: report.titel,
      discreption: report.discreption,
      date: report.date,
      images: report.images,
      lat: report.lat,
      lng: report.lng,
      address: report.address,
      userId: report.userId,
      userName: report.userName,
      userprofile: report.userprofile
    );
  }
}
