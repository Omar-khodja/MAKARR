import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:makarr/navigation_root/presentation/controler/userNotifire.dart';
import 'package:makarr/navigation_root/presentation/screen/home.dart';
import 'package:makarr/navigation_root/presentation/screen/profile.dart';
import 'package:makarr/navigation_root/presentation/screen/report_Problem.dart';

class HomeWithNav extends ConsumerStatefulWidget {
  const HomeWithNav({super.key, required this.uId});
  final String uId;

  @override
  ConsumerState<HomeWithNav> createState() => _HomeWithNavState();
}

class _HomeWithNavState extends ConsumerState<HomeWithNav> {
  int selectedScreen = 0;
  final screen = [const Home(), const ReportProblem(), Profile()];
  final screenTitle = const ["Home", 'Report Problem', "Profile"];
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(userNotifireProvider.notifier).featchCurrentUser(widget.uId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final darcktheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: darcktheme
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.surfaceContainerHigh,
      appBar: AppBar(
        title: Text(screenTitle[selectedScreen]),
        backgroundColor: darcktheme
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.primary,
        foregroundColor: darcktheme
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onPrimary,
      ),
      body: IndexedStack(index: selectedScreen, children: screen),
      bottomNavigationBar: GNav(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        activeColor: darcktheme
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onPrimary,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        tabBackgroundColor: darcktheme
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.primary,
        mainAxisAlignment: .spaceAround,

        gap: 4,
        tabMargin: const EdgeInsetsGeometry.symmetric(vertical: 10),
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: 10,
          horizontal: 10,
        ),

        onTabChange: (index) => setState(() {
          selectedScreen = index;
        }),
        tabs: const [
          GButton(icon: Icons.home_outlined, text: "Home"),
          GButton(icon: Icons.campaign_outlined, text: "Report problem"),
          GButton(icon: Icons.person_outline, text: "Profile"),
        ],
      ),
    );
  }
}
