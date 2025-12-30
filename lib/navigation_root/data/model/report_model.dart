import 'package:makarr/navigation_root/domain/entities/report.dart';

class ReportModel extends Report {
  const ReportModel({
    required super.titel,
    required super.discreption,
    required super.date,
    super.images,
    super.video,
    required super.lat,
    required super.lng,
    required super.address,
  });
  Map<String, dynamic> toMap() {
    return {
      "Title": titel,
      "Discreption": discreption,
      "Date": date,
      "Images": images ?? [],
      "Video": video ?? "",
    };
  }

  factory ReportModel.fromEntity(Report report) {
    return ReportModel(
      titel: report.titel,
      discreption: report.discreption,
      date: report.date,
      images: report.images ?? [],
      video: report.video ?? "",
      lat: report.lat,
      lng: report.lng,
      address: report.address,
    );
  }
}
