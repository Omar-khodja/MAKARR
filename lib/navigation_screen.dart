import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/Home/presentation/screen/add_post.dart';
import 'package:makarr/feature/Home/presentation/screen/home_screen.dart';
import 'package:makarr/feature/Home/presentation/screen/investor_screen.dart';
import 'package:makarr/feature/notification/presentation/screen/notification_screen.dart';
import 'package:makarr/feature/profile/presentation/screen/profile.dart';
import 'package:makarr/feature/Report_Problem/presentation/screen/report_Problem.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<NavigationScreen> createState() => _NavigationScreen();
}

class _NavigationScreen extends ConsumerState<NavigationScreen> {
  int selectedScreen = 0;
  final screenForClient = [
    const HomeScreen(),
    const InvestorScreen(),
    const ReportProblem(),
    Profile(),
  ];
  final screenForAdmin = [
    const HomeScreen(),
    const InvestorScreen(),
    const NotificationScreen(),
    Profile(),
  ];
  final clientScreenTitel = const [
    "Citty Hall",
    "Investment",
    'Report Problem',
    "Profile",
  ];
  final cittyHalltScreenTitel = const [
    "Citty Hall",
    "Investment",
    "Notifications",
    "Profile",
  ];
  final gButtonForClient = const [
    GButton(icon: Icons.home_outlined, text: "Home"),
    GButton(icon: Icons.business_center, text: "Investment"),
    GButton(icon: Icons.campaign_outlined, text: "Report problem"),
    GButton(icon: Icons.person_outline, text: "Profile"),
  ];
  final gButtonForAdmin = const [
    GButton(icon: Icons.home_outlined, text: "Home"),
    GButton(icon: Icons.business_center, text: "Investment"),
    GButton(icon: Icons.notifications_outlined, text: "Notifications"),
    GButton(icon: Icons.person_outline, text: "Profile"),
  ];

  bool isNavBarVissible = true;

  
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifireProvider);
    final darcktheme = Theme.of(context).brightness == Brightness.dark;
    return userState.when(
      data: (user) {
        bool isHeAdmin = user.type == "Client" ? false : true;

        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: darcktheme
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.surfaceContainerHigh,
          
            body: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.reverse) {
                  setState(() {
                    isNavBarVissible = false;
                  });
                }
                if (notification.direction == ScrollDirection.forward) {
                  setState(() {
                    isNavBarVissible = true;
                  });
                }
                return true;
              },
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    backgroundColor: darcktheme
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.primary,
                    foregroundColor: darcktheme
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onPrimary,
                    title: Text(
                      user.type == "Client" || user.type == "Investor"
                          ? clientScreenTitel[selectedScreen]
                          : cittyHalltScreenTitel[selectedScreen],
                    ),
          
                    floating: true,
                    snap: true,
                    pinned: false,
                  ),
                ],
                body: IndexedStack(
                  index: selectedScreen,
                  children: user.type == "Client" || user.type == "Investor"
                      ? screenForClient
                      : screenForAdmin,
                ),
              ),
            ),
            floatingActionButton: isHeAdmin
                ? AnimatedScale(
                    scale: isNavBarVissible ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: FloatingActionButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const AddPost()),
                      ),
                      child: const Icon(Icons.add_box_outlined),
                    ),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
          
            bottomNavigationBar: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isNavBarVissible ? 60 : 0,
              child: Wrap(
                children: [
                  GNav(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainer,
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
                    tabs: isHeAdmin ? gButtonForAdmin : gButtonForClient,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (e, stackTrace) =>
          Scaffold(body: Center(child: Text("${e.toString()} aaaa"))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
