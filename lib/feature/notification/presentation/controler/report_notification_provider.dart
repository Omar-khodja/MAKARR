import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:makarr/core/entities/report.dart';
import 'package:makarr/feature/notification/domain/usecase/report_usecase.dart';
import 'package:makarr/feature/notification/presentation/controler/notification_provider.dart';

class ReportNotificationNotifire
    extends StateNotifier<AsyncValue<List<Report>>> {
  ReportNotificationNotifire({required this.usecase})
    : super(const AsyncValue.loading());
  final ReportUsecase usecase;
  Future<void> getReports(String location) async {
    state = const AsyncValue.loading();
    final response = await usecase.getReport(location);
    state = response.fold(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => AsyncValue.data(r),
    );
  }
}
final reportNotificationProvider = StateNotifierProvider((ref) => ReportNotificationNotifire(usecase: ref.read(reportUseCaseProvider)),);