import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/auth/presentation/controler/authNotifire.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/feature/profile/domain/entities/user_nav.dart';
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
    final auth = ref.read(authNotifierProvider.notifier);
    final userState = ref.watch(userNotifireProvider);
    

    return userState.when(
      data: (user) => Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            ProfileHead(
              imageUrl: user.imagUrl,
              name: "${user.fname} ${user.lname}",
              city: "${user.wilaya} - ${user.bladya}",
            ),
            ...List.generate(titels.length, (index) {
              final data = [user.birthDate, user.phone, user.email];
              return ProfileInfo(
                title: titels[index],
                data: data[index],
                icon: icons[index],
              );
            }),
            const SizedBox(height: 20),
            PrimaryButton(
              label: "Sing Out",
              fun: auth.signOut,
              tailIcon: Icons.logout,
            ),
          ],
        ),
      ),
      error: (e, stackTrace) => Text(e.toString()),
      loading: () { 
        final userepmty = UserNav.empty();
        return Skeletonizer(
          enabled: true,
          child: Column(
            children: [
              ProfileHead(
                imageUrl: userepmty.imagUrl,
                name: "${userepmty.fname} ${userepmty.lname}",
                city: "${userepmty.wilaya} - ${userepmty.bladya}",
              ),
              ...List.generate(titels.length, (index) {
                final data = [userepmty.birthDate, userepmty.phone, userepmty.email];
                return ProfileInfo(
                  title: titels[index],
                  data: data[index],
                  icon: icons[index],
                );
              }),
              const SizedBox(height: 20),
              PrimaryButton(
                label: "Sing Out",
                fun: auth.signOut,
                tailIcon: Icons.logout,
              ),
            ],
          ),
        );
      },
    );
  }
}
