import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/pymente/presentation/controler/subscriptionnotifire.dart';
import 'package:makarr/feature/pymente/presentation/screen/subscription_screen.dart';

class NotSubscriber extends ConsumerWidget {
  const NotSubscriber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscription = ref.watch(subscriptionProvider);

    return subscription.when(
      data: (data) {
        if (data) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 5),
            child: Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const Text(
                    "this section i avilible just for investors!",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  const Text("you can subscribe to upgrade your accounte"),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    child: const Text("Upgrade"),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}
