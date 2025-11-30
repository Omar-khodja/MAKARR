import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makarr/appLogger.dart';
import 'package:makarr/widget/primaryButton.dart';
import 'package:makarr/widget/profile_head.dart';
import 'package:makarr/widget/profile_info.dart';

final _firebaseAuth = FirebaseAuth.instance;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = false;
  Future<void> singOut()async {
    setState(() {
      isLoading = true;
    });
    try {
      await _firebaseAuth.signOut();
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
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            const ProfileHead(name: "Khodja Omar", city: "Msila_Msila"),
            const ProfileInfo(
              title: "Birth Date",
              data: "2001/04/12",
              icon: Icons.calendar_month_outlined,
            ),
            const ProfileInfo(
              title: "Phone",
              data: "0773703289",
              icon: Icons.phone,
            ),
            const ProfileInfo(
              title: "ID",
              data: "1002211589894",
              icon: Icons.badge_outlined,
            ),
            const ProfileInfo(
              title: "Email",
              data: "khodjaomar64@gmail.com",
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
      ),
    );
  }
}
