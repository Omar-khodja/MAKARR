import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:makarr/feature/post/presentation/controler/get_postNotifire.dart';
import 'package:makarr/feature/navigation_root/presentation/controler/userNotifire.dart';
import 'package:makarr/feature/post/presentation/screen/add_post.dart';
import 'package:makarr/feature/post/presentation/screen/citty_hall.dart';
import 'package:makarr/feature/navigation_root/presentation/screen/profile.dart';
import 'package:makarr/feature/navigation_root/presentation/screen/report_Problem.dart';

class HomeWithNav extends ConsumerStatefulWidget {
  const HomeWithNav({super.key, required this.uId});
  final String uId;

  @override
  ConsumerState<HomeWithNav> createState() => _HomeWithNavState();
}

class _HomeWithNavState extends ConsumerState<HomeWithNav> {
  int selectedScreen = 0;
  final screen = [const CittyHall(), const ReportProblem(), Profile()];
  final screenTitle = const ["Citty Hall", 'Report Problem', "Profile"];
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

  @override
  Widget build(BuildContext context) {
    final darcktheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: darcktheme
          ? Colors.black
          : Theme.of(context).colorScheme.surfaceContainerHigh,

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            
            backgroundColor: darcktheme
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.primary,
            foregroundColor: darcktheme
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onPrimary,
            title: Text(screenTitle[selectedScreen]),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddPost()),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
            floating: true,
            snap: true,
            pinned: false,
          ),
        ],
        body: IndexedStack(index: selectedScreen, children: screen),
      ),
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
          GButton(icon: Icons.home_outlined, text: "Citty Hall"),
          GButton(icon: Icons.campaign_outlined, text: "Report problem"),
          GButton(icon: Icons.person_outline, text: "Profile"),
        ],
      ),
    );
  }
}
