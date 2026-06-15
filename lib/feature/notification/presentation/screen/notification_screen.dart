import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/notification/presentation/controler/location_notifire_provider.dart';
import 'package:makarr/feature/notification/presentation/controler/post_title_notifireprovider.dart';
import 'package:makarr/feature/notification/presentation/screen/post_title_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(locationProvider.notifier).getLocations();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationProvider);
    return RefreshIndicator(
      onRefresh: () => ref.read(locationProvider.notifier).getLocations(),
      child: location.when(
        data: (data) => data.isEmpty
            ? const Center(child: Text("Notification are empty"))
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    ref.read(postTitleprovider.notifier).gettitles(data[index]);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PostTitleScreen(),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(data[index]),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
              ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Skeletonizer(
          child: Column(
            mainAxisAlignment: .start,
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
