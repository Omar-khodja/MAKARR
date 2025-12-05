import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/appLogger.dart';
import 'package:makarr/provider/user_Provider.dart';
import 'package:makarr/widget/primaryButton.dart';
import 'package:makarr/widget/profile/profile_head.dart';
import 'package:makarr/widget/profile/profile_info.dart';

final _firebaseAuth = FirebaseAuth.instance;

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  bool isLoading = false;
  Future<void> singOut() async {
    setState(() {
      isLoading = true;
    });
    try {
      await _firebaseAuth.signOut();
      ref.read(userProvider.notifier).clearState;
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      AppLogger.e(
        className: runtimeType.toString(),
        " ${e.message} ,${e.code}",
      );

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? "somthing went worng please try again later",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDate = ref.watch(userProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: userDate == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ProfileHead(
                  name: "${userDate.firstName} ${userDate.lastName}",
                  city: "Msila_Msila",
                ),
                ProfileInfo(
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
                const SizedBox(height: 20),
                PrimaryButton(
                  label: "Sing Out",
                  fun: singOut,
                  tailIcon: Icons.logout,
                  isLoading: isLoading,
                ),
              ],
            ),
    );
  }
}
