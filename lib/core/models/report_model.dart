import 'package:makarr/core/entities/report.dart';

class ReportModel extends Report {
  const ReportModel({
    super.id,
    required super.titel,
    required super.discreption,
    required super.date,
    super.images,
    required super.lat,
    required super.lng,
    required super.address,
    required super.userId,
    required super.userName,
    required super.userprofile,
    super.imagesUrl,
  });
  factory ReportModel.fromJson(Map<String, dynamic> json, String id) {
    return ReportModel(
      id: id,
      titel: json['Title'],
      discreption: json['Discreption'],
      date:  DateTime.parse(json['date']),
      imagesUrl:
          (json['Images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      lat: json['lat'],
      lng: json['lng'],
      address: json['address'],
      userId: json['userId'],
      userName: json['userName'],
      userprofile: json['userprofile'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "Title": titel,
      "Discreption": discreption,
      "lat": lat,
      'lng': lng,
      'address': address,
      "Images": '',
      'date': date.toIso8601String(),
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
      userprofile: report.userprofile,
    );
  }
}
