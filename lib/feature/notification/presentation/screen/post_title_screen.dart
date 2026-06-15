import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/notification/presentation/controler/opinion_notifire_provider.dart';
import 'package:makarr/feature/notification/presentation/controler/post_title_notifireprovider.dart';
import 'package:makarr/feature/notification/presentation/screen/opinions_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostTitleScreen extends ConsumerWidget {
  const PostTitleScreen({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titles = ref.watch(postTitleprovider);
    return Scaffold(
      appBar: AppBar(title: const Text("Posts Titles")),
      body: titles.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              ref
                  .read(opinionsProvider.notifier)
                  .getOpinion(data[index], location);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const OpinionsScreen()),
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
