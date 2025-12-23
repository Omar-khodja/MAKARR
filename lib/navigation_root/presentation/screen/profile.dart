import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/auth/domain/entities/user_auth.dart';
import 'package:makarr/auth/presentation/controler/authNotifire.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/navigation_root/presentation/component/profile/profile_head.dart';
import 'package:makarr/navigation_root/presentation/component/profile/profile_info.dart';
import 'package:makarr/navigation_root/presentation/component/profile/profile_info_shimmer.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  bool isLoading = false;
  final List<String> titels = ["Birth", "Phone", "ID", "Email"];

  final List<IconData> icons = [
    Icons.calendar_month_outlined,
    Icons.phone,
    Icons.badge_outlined,
    Icons.email_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifireProvider.notifier);
    final userDate = const UserAuth(
      id: "1231651",
      firstName: "firstName",
      lastName: "lastName",
      phone: "phone",
      email: "email",
      birthDate: "birthDate",
      password: "password",
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: userDate == null
          ? const ProfileInfoShimmer()
          : Column(
              children: [
                ProfileHead(
                  name: "${userDate.firstName} ${userDate.lastName}",
                  city: "Msila_Msila",
                ),
                ...List.generate(titels.length, (index) {
                  final data = [
                    userDate.birthDate ?? "Unknown",
                    userDate.phone ?? "Unknown",
                    userDate.id ?? "Unknown",
                    userDate.email ?? "Unknown",
                  ];
                  return ProfileInfo(
                    title: titels[index],
                    data: data[index],
                    icon: icons[index],
                  );
                }),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: "Sing Out",
                  fun: auth.singOut,
                  tailIcon: Icons.logout,
                  isLoading: isLoading,
                ),
              ],
            ),
    );
  }
}
/* ProfileInfo(
                  title: "Birth Date",  
                  data: userDate.birthDate ?? "Unkown",
                  icon: Icons.calendar_month_outlined,
                ),
                ProfileInfo(
                  title: "Phone",
                  data: userDate.phone ?? "Unkown",
                  icon: Icons.phone,
                ),
                ProfileInfo(
                  title: "ID",
                  data: userDate.id ?? "Unkown",
                  icon: Icons.badge_outlined,
                ),
                ProfileInfo(
                  title: "Email",
                  data: userDate.email ?? "Unkown",
                  icon: Icons.email_outlined,
                ),
 */