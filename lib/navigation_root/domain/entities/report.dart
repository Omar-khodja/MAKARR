import 'package:equatable/equatable.dart';

class Report extends Equatable {
  const Report({
    this.id,
    required this.titel,
    required this.discreption,
    required this.date,
    this.images,
    this.video,
  });
  final String? id;
  final String titel;
  final String discreption;
  final List<String>? images;
  final String? video;
  final DateTime date;

  @override
  List<Object?> get props => [id, titel, discreption, images, video, date];
}
