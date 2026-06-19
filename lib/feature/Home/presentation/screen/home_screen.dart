import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/presentation/component/post/post_card.dart';
import 'package:makarr/feature/Home/presentation/controler/get_post_provider.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  CarouselController carouselController = CarouselController();
  @override
  void dispose() {
    super.dispose();
    carouselController.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final user = ref.read(userNotifireProvider);
      if (user.value == null) return;
      ref
          .read(getPostNotifireProvider.notifier)
          .getPost("${user.value!.wilaya} - ${user.value!.bladya}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getPostNotifireProvider);
    final user = ref.read(userNotifireProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(getPostNotifireProvider.notifier)
            .getPost("${user.value!.wilaya} - ${user.value!.bladya}");

        Fluttertoast.showToast(
          msg: "Reloading...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16,
        );
      },
      child: state.when(
        data: (data) {
          if (data.isEmpty) return const Center(child: Text("No post yet!!"));

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final post = data[index];
              return PostCard(
                postType: "Client",
                userId: user.value!.id,
                carouselController: carouselController,
                post: post,
              );
            },
          );
        },
        error: (error, stackTrace) => RefreshIndicator(
          onRefresh: () async {
            ref
                .read(getPostNotifireProvider.notifier)
                .getPost("${user.value!.wilaya} - ${user.value!.bladya}");

            Fluttertoast.showToast(
              msg: "Reloading...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 16,
            );
          },
          child: Center(child: Text(error.toString())),
        ),
        loading: () => Skeletonizer(
          enabled: true,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return PostCard(
                postType: "",
                userId: "",
                carouselController: carouselController,
                post: Post(
                  userId: "",
                  title: "",
                  username: "username",
                  userImageUrl:
                      "https://www.bing.com/images/search?view=detailV2&ccid=I7%2BKp6ay&id=A2A6A7B268C0B66E18674F2E7BA5FCEAAEC5012D&thid=OIP.I7-Kp6ayUzLQuonE6-rrlAHaJW&mediaurl=https%3A%2F%2Fwallpapers.com%2Fimages%2Fhd%2Fcute-cat-eyes-profile-picture-uq3edzmg1guze2hh.jpg&cdnurl=https%3A%2F%2Fthfvnext.bing.com%2Fth%2Fid%2FR.23bf8aa7a6b25332d0ba89c4ebeaeb94%3Frik%3DLQHFrur8pXsuTw%26pid%3DImgRaw%26r%3D0&exph=1920&expw=1520&q=profile&form=IRPRST&ck=D54ED5E868F69A02AB4DAF59D40DA746&selectedindex=12&itb=0&cw=1375&ch=659&ajaxhist=0&ajaxserp=0&vt=2&sim=11",
                  desciption:
                      "lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  time: DateTime.now(),
                  pdfName: "",
                  location: "${user.value!.wilaya} - ${user.value!.bladya}",
                  photosUrl: const [
                    "https://www.bing.com/images/search?view=detailV2&ccid=I7%2BKp6ay&id=A2A6A7B268C0B66E18674F2E7BA5FCEAAEC5012D&thid=OIP.I7-Kp6ayUzLQuonE6-rrlAHaJW&mediaurl=https%3A%2F%2Fwallpapers.com%2Fimages%2Fhd%2Fcute-cat-eyes-profile-picture-uq3edzmg1guze2hh.jpg&cdnurl=https%3A%2F%2Fthfvnext.bing.com%2Fth%2Fid%2FR.23bf8aa7a6b25332d0ba89c4ebeaeb94%3Frik%3DLQHFrur8pXsuTw%26pid%3DImgRaw%26r%3D0&exph=1920&expw=1520&q=profile&form=IRPRST&ck=D54ED5E868F69A02AB4DAF59D40DA746&selectedindex=12&itb=0&cw=1375&ch=659&ajaxhist=0&ajaxserp=0&vt=2&sim=11",
                  ],
                  question: "question ?",

                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
