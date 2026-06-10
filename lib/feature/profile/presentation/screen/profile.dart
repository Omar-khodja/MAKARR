import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/auth/presentation/controler/authNotifire.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/feature/profile/presentation/component/profile/profile_head.dart';
import 'package:makarr/feature/profile/presentation/component/profile/profile_info.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Profile extends ConsumerWidget {
  Profile({super.key});

  final List<String> titels = ["Birth", "Phone", "Email"];
  final List<IconData> icons = [
    Icons.calendar_month_outlined,
    Icons.phone,
    Icons.email_outlined,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifireProvider.notifier);
    final user = ref.watch(userNotifireProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Skeletonizer(
            enabled: user.isLoading,
            child: ProfileHead(
              imageUrl: user.user.imagUrl,
              name: "${user.user.fname} ${user.user.lname}",
              city: "${user.user.wilaya} - ${user.user.bladya}",
            ),
          ),
          ...List.generate(titels.length, (index) {
            final data = [
              user.user.birthDate,
              user.user.phone,
              user.user.email,
            ];
            return Skeletonizer(
              enabled: user.isLoading,
              containersColor: Theme.of(context).colorScheme.surface,
              child: ProfileInfo(
                title: titels[index],
                data: data[index],
                icon: icons[index],
              ),
            );
          }),
          const SizedBox(height: 20),
          PrimaryButton(
            label: "Sing Out",
            fun: auth.singOut,
            tailIcon: Icons.logout,
          ),
        ],
      ),
    );
  }
}
