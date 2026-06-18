import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/pymente/presentation/component/subscreption_card.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userNotifireProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("subscribtion")),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(8),
        child: Column(
          children: [
            SubscreptionCard(
              price: "3000",
              title: "Quarterly Plan",
              subTitle: "3 Months of Access",
              triling: "Per Quarter",
              userId: user.value!.id,
            ),
            SubscreptionCard(
              price: "10000",
              title: "Annual Plan",
              subTitle: "1 Year of Access",
              triling: "Per Year",
              userId: user.value!.id,
            ),
          ],
        ),
      ),
    );
  }
}
