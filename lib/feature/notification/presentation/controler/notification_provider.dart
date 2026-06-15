import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/notification/data/datasource/notifications_datasource.dart';
import 'package:makarr/feature/notification/data/repository/notification_rapo.dart';
import 'package:makarr/feature/notification/domain/usecase/get_opinion_usecase.dart';
import 'package:makarr/feature/notification/domain/usecase/get_posttitle_usecase.dart';
import 'package:makarr/feature/notification/domain/usecase/getlocations_usecase.dart';

final notificationsDatasource = Provider((ref) => NotificationsDatasource());
final notificationRepo = Provider(
  (ref) => NotificationRapo(datasource: ref.read(notificationsDatasource)),
);
///////usecase
final getLocationUseCaseProvider = Provider(
  (ref) => GetlocationsUsecase(repo: ref.read(notificationRepo)),
);
final postTitileUseCaseProvider = Provider(
  (ref) => GetPosttitleUsecase(repo: ref.read(notificationRepo)),
);
final getOpinionUseCaseProvider = Provider(
  (ref) => GetOpinionUsecase(repo: ref.read(notificationRepo)),
);
