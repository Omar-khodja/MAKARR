import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makarr/feature/pymente/presentation/controler/subscriptionnotifire.dart';

class SubscreptionCard extends ConsumerStatefulWidget {
  const SubscreptionCard({
    super.key,
    required this.price,
    required this.title,
    required this.subTitle,
    required this.triling,
    required this.userId,
  });
  final String price;
  final String title;
  final String subTitle;
  final String triling;
  final String userId;

  @override
  ConsumerState<SubscreptionCard> createState() => _SubscreptionCardState();
}

class _SubscreptionCardState extends ConsumerState<SubscreptionCard> {
  bool inProgresse = false;
  void _submit() async {
    setState(() {
      inProgresse = true;
    });
    final isdone = await ref
        .watch(subscriptionProvider.notifier)
        .subscription(widget.title, widget.userId);

    final isSubscribed = ref.watch(subscriptionProvider);

    if (isdone) {
      await ref
          .watch(subscriptionProvider.notifier)
          .checkSubscription( widget.userId);

      if (isSubscribed.value!) {
        if (mounted) {
          Fluttertoast.showToast(msg: "Subscription Successful");
          Navigator.of(context).pop();
        }
      } else {
        Fluttertoast.showToast(msg: "somthing went wrong try again");
      }
    }
    setState(() {
      inProgresse = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _submit(),
      child: Stack(
        children: [
          if (inProgresse)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.8),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: .bold,
                                  ),
                                ),
                                Text(widget.subTitle),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "${widget.price} Da",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: .bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  widget.triling,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
