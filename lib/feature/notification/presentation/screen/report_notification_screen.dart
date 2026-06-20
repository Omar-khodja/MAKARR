import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/notification/presentation/component/report_component.dart';
import 'package:makarr/feature/notification/presentation/controler/report_notification_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReportNotificationScreen extends ConsumerWidget {
  const ReportNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportNotificationProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Reports")),
      body: reports.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => ReportComponent(report: data[index]),
        ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Skeletonizer(
          child: Column(
            children: [
              ListTile(title: Text("data")),
              ListTile(title: Text("data")),
              ListTile(title: Text("data")),
            ],
          ),
        ),
      ),
    );
  }
}
