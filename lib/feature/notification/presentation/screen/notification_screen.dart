import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/notification/presentation/controler/opinion_location_notifire_provider.dart';
import 'package:makarr/feature/notification/presentation/controler/post_title_notifireprovider.dart';
import 'package:makarr/feature/notification/presentation/controler/report_location_provider.dart';
import 'package:makarr/feature/notification/presentation/controler/report_notification_provider.dart';
import 'package:makarr/feature/notification/presentation/screen/post_title_screen.dart';
import 'package:makarr/feature/notification/presentation/screen/report_notification_screen.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(opinionLocationProvider.notifier).getLocations();
      ref.read(reportLocationProvider.notifier).getLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final opinionLocation = ref.watch(opinionLocationProvider);
    final reportLocation = ref.watch(reportLocationProvider);

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Locations"),
            Tab(text: "Titles"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              RefreshIndicator(
                onRefresh: () =>
                    ref.read(opinionLocationProvider.notifier).getLocations(),
                child: opinionLocation.when(
                  data: (data) => data.isEmpty
                      ? const Center(child: Text("No Opinion Notifications"))
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) => ListTile(
                            onTap: () {
                              ref
                                  .read(postTitleprovider.notifier)
                                  .gettitles(data[index]);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PostTitleScreen(location: data[index]),
                                ),
                              );
                            },
                            title: Card(
                              child: ListTile(
                                title: Text(data[index]),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                ),
                              ),
                            ),
                          ),
                        ),
                  error: (e, _) => Center(child: Text(e.toString())),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),

              reportLocation.when(
                data: (data) => data.isEmpty
                    ? const Center(child: Text("No Report Notifications"))
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            ref.read(reportNotificationProvider.notifier).getReports(data[index]);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                   const ReportNotificationScreen(),
                              ),
                            );
                          },
                          title: Card(
                            child: ListTile(
                              title: Text(data[index]),
                              trailing: const Icon(
                                Icons.keyboard_arrow_right_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                error: (e, _) => Center(child: Text(e.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
