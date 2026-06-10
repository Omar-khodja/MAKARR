import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:makarr/feature/post/presentation/controler/get_postNotifire.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/post/presentation/screen/add_post.dart';
import 'package:makarr/feature/post/presentation/screen/citty_hall.dart';
import 'package:makarr/feature/profile/presentation/screen/profile.dart';
import 'package:makarr/feature/Report_Problem/presentation/screen/report_Problem.dart';

class HomeWithNav extends ConsumerStatefulWidget {
  const HomeWithNav({super.key, required this.uId});
  final String uId;

  @override
  ConsumerState<HomeWithNav> createState() => _HomeWithNavState();
}

class _HomeWithNavState extends ConsumerState<HomeWithNav> {
  int selectedScreen = 0;
  final screenForClient = [const CittyHall(), const ReportProblem(), Profile()];
  final screenForCittyHall = [const CittyHall(), Profile()];
  final clientScreenTitel = const ["Citty Hall", 'Report Problem', "Profile"];
  final cittyHalltScreenTitel = const ["Citty Hall", "Profile"];
  final gButtonForClient = const [
    GButton(icon: Icons.home_outlined, text: "Home"),
    GButton(icon: Icons.campaign_outlined, text: "Report problem"),
    GButton(icon: Icons.person_outline, text: "Profile"),
  ];
  final gButtonForCittyhall = const [
    GButton(icon: Icons.home_outlined, text: "Home"),

    GButton(icon: Icons.person_outline, text: "Profile"),
  ];
  bool _isNavVisible = true;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifireProvider);
    final darcktheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: darcktheme
          ? Colors.black
          : Theme.of(context).colorScheme.surfaceContainerHigh,

      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              _isNavVisible = false;
            });
          }
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              _isNavVisible = true;
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
                user.user.type == "Client"
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
            children: user.user.type == "Client"
                ? screenForClient
                : screenForCittyHall,
          ),
        ),
      ),
      floatingActionButton: AnimatedScale(
        scale: _isNavVisible ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AddPost())),
          child: const Icon(Icons.add_box_outlined),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isNavVisible ? 60 : 0,
        child: Wrap(
          children: [
            GNav(
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
              tabs: user.user.type == "Client"
                  ? gButtonForClient
                  : gButtonForCittyhall,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(getPostNotifireProvider.notifier).getPost();
      });
      ref.read(userNotifireProvider.notifier).featchCurrentUser(widget.uId);
    });
  }
}
