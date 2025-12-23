import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/auth/presentation/controler/authNotifire.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/navigation_root/presentation/component/profile/profile_head.dart';
import 'package:makarr/navigation_root/presentation/component/profile/profile_info.dart';
import 'package:makarr/navigation_root/presentation/controler/userNotifire.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Profile extends ConsumerWidget {
  Profile({super.key});


  final List<String> titels = ["Birth", "Phone", "ID", "Email"];
  final List<IconData> icons = [
    Icons.calendar_month_outlined,
    Icons.phone,
    Icons.badge_outlined,
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
              name: "${user.user.fname} ${user.user.lname}",
              city: "Msila_Msila",
            ),
          ),
          ...List.generate(titels.length, (index) {
            final data = [
              user.user.birthDate,
              user.user.phone,
              user.user.userId,
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
