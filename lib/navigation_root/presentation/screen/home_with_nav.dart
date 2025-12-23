import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
  final screen = const [Home(), ReportProblem(), Profile()];
  final screenTitle = const ["Home", 'Report Problem', "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(screenTitle[selectedScreen]),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: IndexedStack(index: selectedScreen, children: screen),
      bottomNavigationBar: GNav(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        activeColor: Theme.of(context).colorScheme.onPrimaryContainer,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        tabBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
        mainAxisAlignment: .spaceAround,
        gap: 4,
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: 12,
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
