import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/notification/presentation/controler/opinion_notifire_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OpinionsScreen extends ConsumerWidget {
  const OpinionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opinions = ref.watch(opinionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Opinions")),
      body: opinions.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: 
                    
                    
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: .start,
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            mainAxisAlignment: .start,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                foregroundImage: NetworkImage(data[index].userProfile),
                                backgroundColor: Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                data[index].userName,
                                style: TextStyle(
                                  fontWeight: .w700,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                    
                          Text("${data[index].question} ?"),
                          const SizedBox(height: 10),
                          if(data[index].opinion.isNotEmpty)
                          Text("Answer: ${data[index].opinion}"),
                          const SizedBox(height: 10),
                          Text(data[index].comment ?? ""),
                        ],
                    ),
                  ),
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
